<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .stats-card {
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
</style>

<div class="container-fluid py-4">
    <div class="bg-white border-bottom p-3">
        <h4 class="mb-0">Quản lý người dùng</h4>
    </div>

    <div class="p-4">
        <c:import url="/inc/alert.jsp" />

        <!-- Stats -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <h3 class="text-primary mb-1">${users.size()}</h3>
                    <small class="text-muted">Tổng người dùng</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <h3 class="text-danger mb-1">
                        <c:set var="adminCount" value="0"/>
                        <c:forEach var="u" items="${users}">
                            <c:if test="${u.role == 'admin'}"><c:set var="adminCount" value="${adminCount + 1}"/></c:if>
                        </c:forEach>
                        ${adminCount}
                    </h3>
                    <small class="text-muted">Admin</small>
                </div>
            </div>
        </div>

        <!-- User Table -->
        <div class="bg-white rounded shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0 ps-3">ID</th>
                            <th class="border-0">Username</th>
                            <th class="border-0">Email</th>
                            <th class="border-0">Họ tên</th>
                            <th class="border-0">SĐT</th>
                            <th class="border-0">Quyền</th>
                            <th class="border-0 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="ps-3 align-middle">#${u.id}</td>
                                <td class="align-middle">
                                    <span class="fw-medium">${u.username}</span>
                                </td>
                                <td class="align-middle">${u.email}</td>
                                <td class="align-middle">${u.fullName}</td>
                                <td class="align-middle">${u.phoneNumber}</td>
                                <td class="align-middle">
                                    <span class="badge ${u.role == 'admin' ? 'bg-danger' : 'bg-primary'}">
                                        ${u.role == 'admin' ? 'Admin' : 'User'}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <a href="admin-users?action=edit&id=${u.id}" class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="admin-users" method="post" style="display: inline;" class="me-1">
                                        <input type="hidden" name="action" value="role">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <input type="hidden" name="currentRole" value="${u.role}">
                                        <button type="submit" class="btn btn-sm ${u.role == 'admin' ? 'btn-outline-warning' : 'btn-outline-success'}">
                                            <i class="fas ${u.role == 'admin' ? 'fa-user' : 'fa-crown'}"></i>
                                        </button>
                                    </form>
                                    <a href="admin-users?action=delete&id=${u.id}" class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Xóa người dùng này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty users}">
                <div class="text-center py-5">
                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Chưa có người dùng</h5>
                </div>
            </c:if>
        </div>
    </div>
</div>