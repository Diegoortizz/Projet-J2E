package Controller;

import Modele.Customer;
import Modele.DAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String log = request.getParameter("log");
        String mdp = request.getParameter("mdp");
        String action = request.getParameter("action");

        if (action != null) {
            if ("Deconnexion".equals(action)) {
                exitSession(request, response);
            } else {
                startSession(request, response, action);
            }
        } else {
            showView("login.jsp", request, response);
        }

    }

    private void exitSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        showView("login.jsp", request, response);
    }

    private void startSession(HttpServletRequest request, HttpServletResponse response, String action) throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        String log = request.getParameter("log");
        String mdp = request.getParameter("mdp");

        if (log.equals("admin") && mdp.equals("admin")) {
            
            // TODO Diego : Loop through each Customer and display in table
            
        } else {
            
            DAO dao = new DAO(DataSourceFactory.getDataSource());
            
            Customer c = null;
            try {
                c = dao.Customer(log);
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            String email = c.getEmail();
            String id = Integer.toString(c.getCustomerId());
            
            if ((log == null ? email == null : log.equals(email)) && (mdp == null ? id == null : mdp.equals(id))) {
                
                request.setAttribute("correct", true);
                switch (action) {
                    
                    case "GoToCI":
                                            
                        session.setAttribute("name", c.getName());
                        session.setAttribute("email", c.getEmail());
                        showView("vue_client.jsp", request, response);
                        
                    case "GoToPOI":
                        
                        session.setAttribute("id", c.getCustomerId());
                        showView("ClientPurchaseOrder.jsp", request, response);
                        
            }

            } else {
                request.setAttribute("correct", false);
            }

        }

    }

    private void showView(String jsp, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        getServletConfig().getServletContext().getRequestDispatcher("/" + jsp).forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
