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
  </head>

  <body>
    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <div class="card">
            <div class="card-body">
              <div class="app-brand justify-content-center">
                <span class="app-brand-text demo text-body fw-bolder fs-3">EventZone</span>
              </div>
              <h4 class="mb-2">Welcome to EventZone!</h4>
              <p class="mb-4">Please sign-in to your account.</p>

              <% if(request.getAttribute("errorMessage") !=null) { %>
                <div class="alert alert-danger" role="alert">
                  <%= request.getAttribute("errorMessage") %>
                </div>
                <% } %>

                  <form id="formAuthentication" class="mb-3" action="auths?action=login" method="POST">
                    <div class="mb-3">
                      <label for="username" class="form-label">Username</label>
                      <input type="text" class="form-control" id="username" name="username" placeholder="e.g. sho"
                        autofocus required />
                    </div>
                    <div class="mb-3 form-password-toggle">
                      <div class="d-flex justify-content-between">
                        <label class="form-label" for="password">Password</label>
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

                  <div class="mt-4">
                    <div class="table-responsive">
                      <table class="table table-sm table-bordered text-center">
                        <thead class="table-light">
                          <tr>
                            <th>Role</th>
                            <th>User</th>
                            <th>Pass</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td><span class="badge bg-label-danger">HEPA</span></td>
                            <td>ahmad</td>
                            <td>ahmad123</td>
                          </tr>
                          <tr>
                            <td><span class="badge bg-label-success">Advisor</span></td>
                            <td>sarah</td>
                            <td>sarah123</td>
                          </tr>
                          <tr>
                            <td><span class="badge bg-label-warning">Chairperson</span></td>
                            <td>sho</td>
                            <td>sho123</td>
                          </tr>
                          <tr>
                            <td><span class="badge bg-label-primary">Student</span></td>
                            <td>ali</td>
                            <td>ali123</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>

  </html>