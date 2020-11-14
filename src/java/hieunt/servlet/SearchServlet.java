/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.servlet;

import hieunt.tblcategory.CategoryDAO;
import hieunt.tblcategory.CategoryDTO;
import hieunt.tbllog.LogDAO;
import hieunt.tbllog.LogDTO;
import hieunt.tblpayment.PaymentDAO;
import hieunt.tblpayment.PaymentDTO;
import hieunt.tblproduct.ProductDAO;
import hieunt.tblproduct.ProductDTO;
import hieunt.tbluser.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.StringTokenizer;
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
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

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
        String url = "home.jsp";
        try {

            HttpSession s = request.getSession();
            UserDTO uDTO = (UserDTO) s.getAttribute("USER_DTO");

            int page = 1;
            if (request.getParameter("btnPage") != null) {
                page = Integer.parseInt(request.getParameter("btnPage"));
            }

            ProductDAO pDAO = new ProductDAO();
            String name = "";
            if (request.getParameter("txtSearch") != null) {
                name = request.getParameter("txtSearch");
            }
            String category = "";
            if (request.getParameter("txtCategory") != null) {
                category = request.getParameter("txtCategory");
            }
            request.setAttribute("SELECTED_CATEGORY", category);
            int min, max;
            String p = "All price";
            if (request.getParameter("cbPrice") != null) {
                p = request.getParameter("cbPrice");
            }
            if (!p.contains("A")) {
                if (p.trim().equals("")) {
                    min = 0;
                    max = pDAO.getMaxPrice();
                } else {
                    StringTokenizer stk = new StringTokenizer(p, "-");
                    min = Integer.parseInt(stk.nextToken().trim());
                    max = Integer.parseInt(stk.nextToken().trim());
                }
            } else {
                max = pDAO.getMaxPrice();
                if (p.equals("All price")) {
                    min = 0;
                } else {
                    min = 250000;
                }
            }
            request.setAttribute("SELECTED_COMBOBOX", p);

            CategoryDAO cDAO = new CategoryDAO();
            List<CategoryDTO> cList = cDAO.getCategoryList();
            request.setAttribute("CATEGORY_LIST", cList);

            PaymentDAO paDAO = new PaymentDAO();
            List<PaymentDTO> paList = paDAO.getPaymentList();
            s.setAttribute("PAYMENT", paList);

            List<ProductDTO> pList;
            int pageCount;
            if (uDTO != null && uDTO.getRole().equals("AD")) {
                pList = pDAO.getProductListForAdmin(name, category, min, max, page);
                pageCount = pDAO.pageCountForAdmin(name, category, min, max);
            } else {
                pList = pDAO.getProductListForUser(name, category, min, max, page);
                pageCount = pDAO.pageCountForUser(name, category, min, max);
            }

            LogDAO lDAO = new LogDAO();
            List<LogDTO> lList = lDAO.viewLog();
            if (lList != null) {
                s.setAttribute("LOG_LIST", lList);
            }

            if (pList != null) {
                request.setAttribute("PAGE_COUNT", pageCount);
                request.setAttribute("PRODUCT_LIST", pList);
            } else {
                request.setAttribute("NOT_FOUND", "Not Found");
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
