import com.lab.dao.UserDAO;
import com.lab.dao.MeritDAO;
import com.lab.model.User;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/auths")
public class AuthController extends HttpServlet {

    private UserDAO userDAO;
    private MeritDAO meritDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        meritDAO = new MeritDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("Login.jsp");
        } else {
            response.sendRedirect("Homepage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            try {
                String name = request.getParameter("username");
                String pass = request.getParameter("password");

                User validUser = userDAO.authenticate(name, pass);

                if (validUser != null) {
                    // SUCCESS: Forward to the account page & persist in session
                    request.getSession().setAttribute("name", validUser.getFullName());
                    request.getSession().setAttribute("email", validUser.getEmail());
                    request.getSession().setAttribute("accountType", validUser.getRole());
                    request.getSession().setAttribute("userId", validUser.getUserId());
                    request.getSession().setAttribute("totalMerits", meritDAO.getTotalMerits(validUser.getUserId()));

                    response.sendRedirect("Homepage.jsp");

                } else {
                    // FAILURE: Send back to login.jsp with a message
                    request.setAttribute("errorMessage", "Wrong username or password!");
                    RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                    rd.forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
