<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Footer -->
    <footer class="layout-navbar navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
        id="layout-footer" style="margin: 0.75 auto 0.75rem !important; display: none; margin-bottom: 20px;">
        <div class="container-fluid d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column align-items-center"
            style="width: 100%; padding: 0;">
            <div class="mb-2 mb-md-0 text-muted" style="font-size: 0.85rem; font-weight: 500;">
                ©
                <script>document.write(new Date().getFullYear());</script> EventZone. All rights reserved.
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="footer-role-badge text-uppercase">${accountType} Portal</span>
            </div>
        </div>
    </footer>
    <!-- / Footer -->

    <!-- Core JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/bootstrap.js"></script>
    <script
        src="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/menu.js"></script>

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

    <!-- Dynamic Footer Placement Script -->
    <script>
        $(document).ready(function () {
            var $contentWrapper = $('.content-wrapper');
            if ($contentWrapper.length > 0) {
                var $footer = $('#layout-footer');
                $footer.insertAfter($contentWrapper);
                $footer.show();
            }
        });
    </script>