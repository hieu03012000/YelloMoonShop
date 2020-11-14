/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.servlet;

import hieunt.tbloder.OrderDAO;
import hieunt.tbloder.OrderDTO;
import hieunt.tblorderdetail.OrderDetailDAO;
import hieunt.tblorderdetail.OrderDetailDTO;
import hieunt.tbluser.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
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
@WebServlet(name = "SearchOrderDetail", urlPatterns = {"/SearchOrderDetail"})
public class SearchOrderDetail extends HttpServlet {

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
            String orderID = "";
            if (request.getParameter("txtSearchOrder") != null) {
                orderID = request.getParameter("txtSearchOrder");
            }
            HttpSession s = request.getSession();
            UserDTO uDTO = (UserDTO) s.getAttribute("USER_DTO");
            OrderDAO oDAO = new OrderDAO();
            OrderDTO oDTO = oDAO.getOrder(orderID);
            if (oDTO != null) {
                if (!oDTO.getUserID().equals(uDTO.getEmail())) {
                    url = "SearchServlet";
                    request.setAttribute("NOT_FOUND_DETAIL", "Not fount order");
                } else {
                    OrderDetailDAO odDAO = new OrderDetailDAO();
                    List<OrderDetailDTO> list = odDAO.getDetail(orderID);
                    request.setAttribute("O_DTO", oDTO);
                    request.setAttribute("OD_DTO_LIST", list);
                    request.setAttribute("OID", orderID);
                    url = "orderDetail.jsp";
                }
            }
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
