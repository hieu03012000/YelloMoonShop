/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.servlet;

import hieunt.tbluser.GoogleDTO;
import hieunt.tbluser.UserDAO;
import hieunt.tbluser.UserDTO;
import hieunt.util.GoogleUtil;
import hieunt.util.PasswordEncryption;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.naming.NamingException;
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
@WebServlet(name = "LoginGoogleServlet", urlPatterns = {"/login-google"})
public class LoginGoogleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger log = LogManager.getLogger(AddToCartServlet.class);

    public LoginGoogleServlet() {
        super();
    }

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
        String code = request.getParameter("code");
        HttpSession s = request.getSession();
        String url = "SearchServlet";

        try {
            if (code == null || code.isEmpty()) {
                url = "login.jsp";
            } else {
                

                String accessToken = GoogleUtil.getToken(code);
                GoogleDTO gDTO = GoogleUtil.getUserInfo(accessToken);
                s.setAttribute("TEST", gDTO.getEmail());
                String name = gDTO.getName();
                String email = gDTO.getEmail();
                if(name == null) {
                    name = email;
                }
                PasswordEncryption pe = new PasswordEncryption();
                String password = pe.toSHAString("OSUSFGBSKJB");
                UserDAO uDAO = new UserDAO();
                UserDTO uDTO = uDAO.getUserDTO(email, password);

                if (uDTO != null) {
                    s.setAttribute("USER_DTO", uDTO);
                } else {
                    uDTO = new UserDTO(email, name, password, "U", "");
                    uDAO.addAccount(uDTO);
                    s.setAttribute("USER_DTO", uDTO);
                }

            }

        } catch (SQLException ex) {
            log.error("SQL_" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("Naming_" + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log.error("NoSuch_" + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
