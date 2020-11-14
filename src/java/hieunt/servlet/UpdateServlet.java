/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.servlet;

import hieunt.tbllog.LogDAO;
import hieunt.tbllog.LogDTO;
import hieunt.tblproduct.ProductDAO;
import hieunt.tblproduct.ProductDTO;
import hieunt.tblproduct.UpdateProductError;
import hieunt.tbluser.UserDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author HIEUNGUYEN
 */
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {
    
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
            boolean isMutilPart = ServletFileUpload.isMultipartContent(request);
            if (!isMutilPart) {

            } else {
                ProductDAO pDAO = new ProductDAO();
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);
                } catch (FileUploadException e) {
                    log("NewPostServlet_FileUpload_" + e.getMessage());
                }
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            String itemName = item.getName();
                            fileName = itemName.substring(items.lastIndexOf("\\") + 1);
                            String realPath = getServletContext().getRealPath("/") + "img\\" + fileName;
                            File savedFile = new File(realPath);
                            item.write(savedFile);
                        } catch (Exception ex) {
                            log("NewPostServlet_" + ex.getMessage());
                        }
                    }
                }

                UpdateProductError errors = new UpdateProductError();
                boolean err = false;
                String productID = ((String) params.get("txtProductID")).trim();
                String name = "";
                if (params.get("txtName") != null) {
                    name = (String) params.get("txtName");
                }
                if (name.length() < 3 && name.length() > 50) {
                    errors.setNameError("Name length 3 to 50");
                    err = true;
                }
                String p = "";
                float price = 0;
                if (params.get("txtPrice") != null) {
                    p = (String) params.get("txtPrice");
                }
                try {
                    price = Float.parseFloat(p);
                    if (price < 0) {
                        errors.setPriceError("Price must not smaller than 0");
                        err = true;
                    }
                } catch (NumberFormatException e) {
                    errors.setPriceError("Price is a float");
                    err = true;
                }
                String q = "";
                int quantity = 0;
                if (params.get("txtQuantity") != null) {
                    q = (String) params.get("txtQuantity");
                }
                try {
                    quantity = Integer.parseInt(q);
                    if (quantity < 0) {
                        errors.setPriceError("Quantity must not smaller than 0");
                        err = true;
                    }
                } catch (NumberFormatException e) {
                    errors.setQuantityError("Quantity is an integer");
                    err = true;
                }

                String description = "";
                if (params.get("txtNewDescription") != null) {
                    description = (String) params.get("txtNewDescription");
                }
                if (description.length() < 3 && description.length() > 300) {
                    errors.setNameError("Description length 3 to 300");
                    err = true;
                }

                String image = "";
                if (fileName != null && !fileName.trim().equals("")) {
                    int dot = fileName.lastIndexOf(".");
                    String type = fileName.substring(dot + 1);
                    if (type.equals("jpg") || type.equals("gif") || type.equals("png")) {
                        image = "./img/" + fileName;
                    }
                } else {
                    image = pDAO.getImageByID(productID);
                }
                String c = "";
                if (params.get("txtCDate") != null) {
                    c = (String) params.get("txtCDate");
                }
                String e = "";
                if (params.get("txtEDate") != null) {
                    e = (String) params.get("txtEDate");
                }
                if (c.equals("") || e.equals("")) {
                    errors.setcDateError("Choose correct date");
                    err = true;
                } else {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date date1 = format.parse(c);
                    Date date2 = format.parse(e);
                    if (date1.compareTo(date2) > 0) {
                        errors.seteDateError("Create day before ex day");
                        err = true;
                    }
                }
                String category = "";
                if (params.get("cbCategory") != null) {
                    category = (String) params.get("cbCategory");
                }
                String s;
                boolean status = true;
                if (params.get("cbStatus") != null) {
                    s = (String) params.get("cbStatus");
                    if (s.equals("Inactive")) {
                        status = false;
                    }
                }
                HttpSession session = request.getSession();
                if (!err) {
                    LogDAO lDAO = new LogDAO();
                    if(lDAO.isUpdated(productID)){
                        lDAO.deleteLog(productID);
                    }
                    UserDTO uDTO = (UserDTO) session.getAttribute("USER_DTO");
                    session.removeAttribute("ERROR");
                    lDAO.addLog(new LogDTO("", uDTO.getEmail(), productID, "", "update"));
                    ProductDTO pDTO = new ProductDTO(productID, name, price, quantity, image, c, e, category, status, description);
                    pDAO.updateProduct(pDTO);
                } else {
                    session.setAttribute("ERROR", "Can not update");
                }
            }
        } catch (SQLException ex) {
            log.error("SQL_" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("Naming_" + ex.getMessage());
        } catch (ParseException ex) {
            log.error("Parse_" + ex.getMessage());
        } finally {
//            RequestDispatcher rd = request.getRequestDispatcher(url);
//            rd.forward(request, response);
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
