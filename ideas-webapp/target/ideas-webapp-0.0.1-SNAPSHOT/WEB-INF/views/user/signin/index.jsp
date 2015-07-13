<%--
  Created by IntelliJ IDEA.
  User: zhaiwenhao
  Date: 15/6/25
  Time: 16:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>ideas</title>
        <!-- Set render engine for 360 browser -->
        <meta name="renderer" content="webkit">
        <!-- No Baidu Siteapp -->
        <meta http-equiv="Cache-Control" content="no-siteapp">
        <!-- Add to homescreen for Chrome on Android -->
        <meta name="mobile-web-app-capable" content="yes">

        <link href="<%=request.getContextPath()%>/resource/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/css/signin.css" type="text/css" rel="stylesheet"/>

        <style type="text/css">
            #signinForm label.error {
                color: red;
            }
            #signinForm input.error {
                border-color: red;
            }
        </style>

    </head>

    <body>
        <!-- top 菜单 begin -->
        <jsp:include page="/WEB-INF/views/base/top.jsp" />
        <!-- top 菜单 end -->

        <div class="container">

            <form id="signinForm" class="form-signin" method="POST" action="<%=request.getContextPath() %>/user/login.do">
                <div class="form-group">
                    <label for="input_email">邮箱地址</label>
                    <input type="email" class="form-control" id="input_email" name="email" placeholder="邮箱地址" required/>
                </div>
                <div class="form-group">
                    <label for="input_password">您的密码</label>
                    <input type="password" class="form-control" id="input_password" name="password" placeholder="您的密码" required/>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">登 录</button>
            </form>

            <jsp:include page="/WEB-INF/views/base/foot.jsp" />

        </div>
        <!--/.container-->
    </body>

    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/additional-methods.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/localization/messages_zh.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $("#signinForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });

        });
    </script>
</html>