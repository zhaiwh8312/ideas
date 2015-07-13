<%--
  Created by IntelliJ IDEA.
  User: zhaiwenhao
  Date: 15/6/25
  Time: 16:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>${playerInfo.playerLastName}${playerInfo.playerFirstName}</title>

        <link href="<%=request.getContextPath()%>/resource/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>

        <style type="text/css" >
            * {
                border-radius: 0px!important;
            }
        </style>
    </head>

    <body style="padding-top: 70px;">
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">IDEAS</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="">主页</a></li>
                        <li><a href="#about">我的Idea</a></li>
                        <li><a href="#contact">Contact</a></li>
                        <li><a href="">About</a></li>
                        <%--<li class="dropdown">--%>
                            <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>--%>
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
                </div><!--/.nav-collapse -->
            </div>
        </nav>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">球员资料－属性</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3" style="padding-left: 0px; padding-right: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" style="padding-left: 0px; padding-right: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    2
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" style="padding-left: 0px; padding-right: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    3
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" style="padding-left: 0px; padding-right: 0px;">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    4
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</html>