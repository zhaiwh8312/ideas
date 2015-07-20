<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- top 菜单 begin -->
        <nav class="navbar navbar-inverse navbar-static-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<%=request.getContextPath()%>/">
                        <i class="fa fa-lightbulb-o fa-lg"></i>
                        IDEAS
                    </a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="<%=request.getContextPath()%>/">首页</a></li>
                        <%--<li><a href="#about">公共仓库</a></li>--%>
                        <li><a href="<%=request.getContextPath()%>/myideas/index.html">我的仓库</a></li>
                        <li><a href="javascript:;" data-toggle="modal" data-target="#about_modal">关于</a></li>
                        <%--<li class="dropdown">--%>
                            <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"--%>
                               <%--aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>--%>
                            <%--<ul class="dropdown-menu">--%>
                                <%--<li><a href="#">Action</a></li>--%>
                                <%--<li><a href="#">Another action</a></li>--%>
                                <%--<li><a href="#">Something else here</a></li>--%>
                                <%--<li role="separator" class="divider"></li>--%>
                                <%--<li class="dropdown-header">Nav header</li>--%>
                                <%--<li><a href="#">Separated link</a></li>--%>
                                <%--<li><a href="#">One more separated link</a></li>--%>
                            <%--</ul>--%>
                        <%--</li>--%>
                    </ul>
                    <c:choose>
                        <c:when test="${null != sessionScope.user}">
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                       aria-haspopup="true" aria-expanded="false">${sessionScope.user.email} <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <%--<li><a href="#">Action</a></li>--%>
                                        <%--<li><a href="#">Another action</a></li>--%>
                                        <%--<li><a href="#">Something else here</a></li>--%>
                                        <%--<li role="separator" class="divider"></li>--%>
                                        <%--<li class="dropdown-header">Nav header</li>--%>
                                        <%--<li><a href="#">Separated link</a></li>--%>
                                        <li><a href="<%=request.getContextPath()%>/user/logout.do">注销</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <form class="navbar-form navbar-right" role="search">
                                <a href="<%=request.getContextPath()%>/" class="btn btn-success" role="button">注 册</a>
                                <a href="<%=request.getContextPath()%>/user/login.html" class="btn btn-default" role="button">登 录</a>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
        <!-- top 菜单 end -->

        <div id="about_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">About</h4>
                    </div>
                    <div class="modal-body">
                        <p>made by zhaiwenhao</p>
                    </div>
                </div>
            </div>
        </div>