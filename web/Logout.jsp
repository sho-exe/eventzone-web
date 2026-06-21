<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% 
    String userRole = null;
    if (session != null) {
        try {
            userRole = (String) session.getAttribute("accountType");
            session.invalidate();
        } catch (IllegalStateException e) {
            // Session already invalidated
        }
    }

    String accentColor = "#696cff", accentLight = "rgba(105,108,255,0.12)", accentHex = "#696cff";
    if ("HEPA".equals(userRole)) {
        accentColor = "#ea5455";
        accentLight = "rgba(234,84,85,0.12)";
        accentHex = "#ea5455";
    } else if ("ADVISOR".equals(userRole)) {
        accentColor = "#28c76f";
        accentLight = "rgba(40,199,111,0.12)";
        accentHex = "#28c76f";
    } else if ("CHAIRPERSON".equals(userRole)) {
        accentColor = "#ff9f43";
        accentLight = "rgba(255,159,67,0.12)";
        accentHex = "#ff9f43";
    }
%>
<jsp:include page="header.jsp" />
<meta http-equiv="refresh" content="3;url=Login.jsp">
<style>
  :root {
    --role-accent: <%= accentColor %> !important;
    --role-accent-light: <%= accentLight %> !important;
    --role-accent-hex: <%= accentHex %> !important;
  }
  body {
    background: radial-gradient(circle at 10% 20%, rgba(105, 108, 255, 0.08) 0%, rgba(198, 204, 255, 0.08) 90%), #f5f5f9 !important;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .authentication-wrapper.authentication-basic {
    align-items: center;
    justify-content: center;
    width: 100%;
  }
  .card {
    border: none !important;
    border-radius: 16px !important;
    box-shadow: 0 15px 35px rgba(105, 108, 255, 0.08) !important;
    background-color: rgba(255, 255, 255, 0.95) !important;
    backdrop-filter: blur(15px);
    overflow: hidden;
    transition: all 0.3s ease;
  }
  .card:hover {
    box-shadow: 0 20px 45px rgba(105, 108, 255, 0.15) !important;
  }
  .text-primary {
    color: <%= accentColor %> !important;
  }
  .spinner-border.text-primary {
    border-color: <%= accentColor %> !important;
    border-right-color: transparent !important;
  }
  .btn-outline-primary {
    color: <%= accentColor %> !important;
    border-color: <%= accentColor %> !important;
    background: transparent !important;
  }
  .btn-outline-primary:hover {
    background-color: <%= accentColor %> !important;
    color: #fff !important;
  }
</style>

<body>
  <div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
      <div class="authentication-inner text-center" style="max-width: 440px; width: 100%; margin: 0 auto;">
        <div class="card">
          <div class="card-body p-5">
            <h2 class="mb-4 fw-bold text-primary">Logged Out Successfully</h2>
            <p class="mb-4">You have been securely signed out of the Student Event Registration System.</p>
            <div class="spinner-border text-primary mb-4" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
            <p class="text-muted small">Redirecting you to the login page in <span id="countdown">3</span> seconds...</p>
            <a href="Login.jsp" class="btn btn-outline-primary mt-3">Return to Login Now</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    let timeLeft = 3;
    const countdownElement = document.getElementById('countdown');

    const timer = setInterval(() => {
      timeLeft--;
      if (countdownElement) {
        countdownElement.textContent = timeLeft;
      }
      if (timeLeft <= 0) {
        clearInterval(timer);
        window.location.href = "Login.jsp";
      }
    }, 1000);
  </script>
</body>
</html>