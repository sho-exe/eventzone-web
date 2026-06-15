<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" class="light-style customizer-hide">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | EventZone</title>
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
    rel="stylesheet" />

  <!-- Icons -->
  <link rel="stylesheet" href="resources/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="resources/assets/css/demo.css" />

  <!-- Page CSS -->
  <link rel="stylesheet" href="resources/assets/vendor/css/pages/page-auth.css" />

  <!-- Custom CSS Overrides for Premium Aesthetic -->
  <style>
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
    .app-brand-text {
      font-family: 'Public Sans', sans-serif !important;
      font-weight: 800 !important;
      background: linear-gradient(135deg, #696cff, #3e42ff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: -0.03em;
    }
    .btn-primary {
      background: linear-gradient(135deg, #696cff 0%, #3e42ff 100%) !important;
      border: none !important;
      border-radius: 10px !important;
      padding: 0.65rem 1.25rem !important;
      font-weight: 600 !important;
      box-shadow: 0 4px 12px rgba(105, 108, 255, 0.25) !important;
      transition: all 0.2s ease-in-out !important;
    }
    .btn-primary:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 16px rgba(105, 108, 255, 0.35) !important;
      opacity: 0.95 !important;
    }
    .form-control {
      border: 1.5px solid #d9dee3 !important;
      border-radius: 8px !important;
      padding: 0.625rem 0.95rem !important;
      transition: all 0.2s ease-in-out !important;
    }
    .form-control:focus {
      border-color: #696cff !important;
      box-shadow: 0 0 0 0.25rem rgba(105, 108, 255, 0.12) !important;
    }
    .quick-login-btn {
      transition: all 0.2s ease-in-out;
      border-width: 1.5px !important;
      border-radius: 10px !important;
      background: #ffffff !important;
      cursor: pointer;
      text-decoration: none;
    }
    .quick-login-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05) !important;
    }
    .quick-login-btn:active, .quick-login-btn.active {
      transform: scale(0.95);
    }
  </style>
</head>

<body>
  <div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
      <div class="authentication-inner" style="max-width: 440px; width: 100%;">
        <div class="card">
          <div class="card-body p-4 p-md-5">
            <div class="app-brand justify-content-center mb-4">
              <span class="app-brand-text demo text-body fw-bolder fs-3">EventZone - FSKM</span>
            </div>
            <h4 class="mb-2 fw-bold text-dark text-center">Welcome to EventZone!</h4>
            <p class="mb-4 text-muted text-center">Please sign-in to your account.</p>

            <% if(request.getAttribute("errorMessage") !=null) { %>
              <div class="alert alert-danger border-0 shadow-sm" role="alert">
                <i class="bx bx-error-circle me-1"></i> <%= request.getAttribute("errorMessage") %>
              </div>
              <% } %>

            <form id="formAuthentication" class="mb-3" action="auths?action=login" method="POST">
              <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Username</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="e.g. sho"
                  autofocus required />
              </div>
              <div class="mb-4 form-password-toggle">
                <div class="d-flex justify-content-between mb-1">
                  <label class="form-label fw-semibold mb-0" for="password">Password</label>
                </div>
                <div class="input-group input-group-merge">
                  <input type="password" id="password" class="form-control" name="password"
                    placeholder="Enter password" required />
                </div>
              </div>
              <div class="mb-3">
                <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
              </div>
            </form>

            <div class="mt-4 pt-3 border-top">
              <p class="text-center text-muted small fw-bold mb-3 text-uppercase" style="letter-spacing: 0.05em;">Quick Login (Demo Accounts)</p>
              <div class="row g-2">
                <div class="col-6">
                  <button type="button" class="btn btn-outline-danger btn-sm w-100 d-flex flex-column align-items-center py-2 quick-login-btn" data-username="ahmad" data-password="ahmad123">
                    <span class="badge bg-label-danger mb-1 fw-bold">HEPA</span>
                    <span class="small text-muted font-monospace">ahmad</span>
                  </button>
                </div>
                <div class="col-6">
                  <button type="button" class="btn btn-outline-success btn-sm w-100 d-flex flex-column align-items-center py-2 quick-login-btn" data-username="sarah" data-password="sarah123">
                    <span class="badge bg-label-success mb-1 fw-bold">Advisor</span>
                    <span class="small text-muted font-monospace">sarah</span>
                  </button>
                </div>
                <div class="col-6">
                  <button type="button" class="btn btn-outline-warning btn-sm w-100 d-flex flex-column align-items-center py-2 quick-login-btn" data-username="sho" data-password="sho123">
                    <span class="badge bg-label-warning mb-1 fw-bold">Chairperson</span>
                    <span class="small text-muted font-monospace">sho</span>
                  </button>
                </div>
                <div class="col-6">
                  <button type="button" class="btn btn-outline-primary btn-sm w-100 d-flex flex-column align-items-center py-2 quick-login-btn" data-username="ali" data-password="ali123">
                    <span class="badge bg-label-primary mb-1 fw-bold">Student</span>
                    <span class="small text-muted font-monospace">ali</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Javascript to Auto-Fill Credentials -->
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      document.querySelectorAll('.quick-login-btn').forEach(btn => {
        btn.addEventListener('click', function() {
          document.getElementById('username').value = this.getAttribute('data-username');
          document.getElementById('password').value = this.getAttribute('data-password');
          
          // Add instant press effect
          this.classList.add('active');
          setTimeout(() => this.classList.remove('active'), 150);
        });
      });
    });
  </script>
</body>

</html>