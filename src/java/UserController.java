import com.lab.dao.UserDAO;
import com.lab.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/users")
public class UserController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Must be logged in
        HttpSession session = request.getSession(false);
        String accountType = session != null ? (String) session.getAttribute("accountType") : null;
        if (accountType == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action == null || "manage".equals(action)) {
            // HEPA only
            if (!"HEPA".equals(accountType)) {
                response.sendRedirect("Homepage.jsp");
                return;
            }
            List<User> userList = userDAO.selectAllUsers();
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("ManageUsers.jsp").forward(request, response);

        } else if ("profile".equals(action)) {
            // Any role: view/edit own profile
            int userId = (int) session.getAttribute("userId");
            User user = userDAO.getUserById(userId);
            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("StudentProfile.jsp").forward(request, response);

        } else {
            response.sendRedirect("Homepage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateRole".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String newRole = request.getParameter("newRole");
            userDAO.updateUserRole(userId, newRole);
            response.sendRedirect("users?action=manage");

        } else if ("updateProfile".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("Login.jsp");
                return;
            }
            int userId = (int) session.getAttribute("userId");
            String fullName    = request.getParameter("fullName");
            String email       = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");

            boolean updated = userDAO.updateUserProfile(userId, fullName, email, newPassword);

            if (updated) {
                session.setAttribute("name", fullName);
                session.setAttribute("email", email);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }

            User user = userDAO.getUserById(userId);
            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("StudentProfile.jsp").forward(request, response);
        }
    }
}
