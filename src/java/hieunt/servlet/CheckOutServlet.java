/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.servlet;

import hieunt.tbloder.OrderDTO;
import hieunt.cart.CartObj;
import hieunt.tbloder.OrderDAO;
import hieunt.tblorderdetail.OrderDetailDAO;
import hieunt.tblproduct.ProductDAO;
import hieunt.tbluser.UserDAO;
import hieunt.tbluser.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author HIEUNGUYEN
 */
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {
    
    private static final Logger log = LogManager.getLogger(AddToCartServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "SearchServlet";
        try {
            String userID;
            HttpSession s = request.getSession();
            CartObj cart = (CartObj) s.getAttribute("CART");
            UserDTO dto = (UserDTO) s.getAttribute("USER_DTO");
            String payment = request.getParameter("cpPayment");
            String address = request.getParameter("txtAddress");
            OrderDTO oDTO;
            if (dto != null) {
                oDTO = new OrderDTO(cart.getTotal(), "", address, payment, dto.getEmail());
                userID = dto.getEmail();
            } else {
                UserDAO uDAO = new UserDAO();
                userID = uDAO.getRandomUserID();
                UserDTO uDTO = new UserDTO(userID, userID, "1234567", "U", "");
                uDAO.addAccount(uDTO);
                oDTO = new OrderDTO(cart.getTotal(), "", address, payment, userID);
            }
            OrderDAO oDAO = new OrderDAO();
            oDAO.addOrder(oDTO);
            String oID = oDAO.getNewestOrderID(userID);
            OrderDetailDAO odDAO = new OrderDetailDAO();
            odDAO.addDetail(cart.getCakeList(), oID);
            ProductDAO pDAO = new ProductDAO();
            pDAO.changeQuantity(cart.getCakeList());
            request.setAttribute("OID", oID);
            s.removeAttribute("CART");
        } catch (SQLException ex) {
            log.error("SQL_" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("Naming_" + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
