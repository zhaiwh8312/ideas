<%--
  Created by IntelliJ IDEA.
  User: zhaiwenhao
  Date: 15/6/25
  Time: 16:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

        <link href="<%=request.getContextPath()%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"
              rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css"
              type="text/css" rel="stylesheet"/>
        <link href="<%=request.getContextPath()%>/resource/font-awesome/css/font-awesome.min.css" type="text/css"
              rel="stylesheet"/>

        <style type="text/css">
            #addForm label.error {
                color: red;
            }

            #addForm input.error {
                border-color: red;
            }

            h2, h3 {
                margin-top : 0px;
                margin-bottom: 10px;
            }
        </style>
    </head>

    <body>
        <!-- top 菜单 begin -->
        <jsp:include page="/WEB-INF/views/base/top.jsp"/>
        <!-- top 菜单 end -->

        <div class="container">
            <div id="drawingboard_div" class="row row-offcanvas row-offcanvas-right" style="width:100%; height: 1000px; background-color: #EAEAEA; position: relative; border: 1px solid red">
                <canvas id='canvas_div' style='border:1px solid green;' height="1000px"></canvas>
            </div>
            <div class="btn-group">
                <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Action <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                </ul>
            </div>

            <div id="modal_add_node" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <%--<div class="modal-header">--%>
                            <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                            <%--<h4 class="modal-title" id="gridSystemModalLabel">创建我的idea</h4>--%>
                        <%--</div>--%>
                        <div class="modal-body">
                            <form id="addForm" class="form-signup">
                                <div class="form-group">
                                    <label for="input_node_content">创建节点</label>
                                    <input type="text" class="form-control" id="input_node_content" name="nodeContent" placeholder="内容" required/>
                                </div>
                                <%--<div class="form-group">--%>
                                    <%--<input type="checkbox" id="input_isPublic" name="isPublic" checked data-on-text="公开" data-off-text="私人" data-on-color="primary" data-off-color="danger"/>--%>
                                <%--</div>--%>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <button class="btn btn-success btn-block" type="button" onclick="doAddNode()">
                                                <i class="fa fa-save"></i>&nbsp;&nbsp;确 定
                                            </button>
                                        </div>
                                        <div class="col-xs-6">
                                            <button class="btn btn-warning btn-block" type="button" onclick="doRest()">
                                                <i class="fa fa-reply"></i>&nbsp;&nbsp;重 置
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="/WEB-INF/views/base/foot.jsp"/>
        </div>
        <!--/.container-->
    </body>

    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/additional-methods.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/validate/localization/messages_zh.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resource/js/jquery.lazyload.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var canvas;
        var context;

        $(document).ready(function () {
            getCanvas();

            canvas.width = $("#drawingboard_div").css("width").split("px")[0];

            <c:if test="${null != sessionScope.user && sessionScope.user.userId == ideaInfo.userId && fn:length(nodeInfoList) == 0}">
            $("#modal_add_node").modal("show");
            </c:if>
        });

        function doAddNode() {
//            var str = "<div id='test1' style='position: absolute; border:1px solid red; width: auto; top: 100px; left: 400px; cursor: pointer'>root</div>";

            var str = "<div id='test11' style='position: absolute; border:1px solid red; top: 500px; left: 400px; cursor: pointer'>" +
                    "<div class='btn-group'>" +
                    "<a class='btn btn-success btn-block' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>确 定</a>" +
                    "<ul class='dropdown-menu'><li><a href='#'>Action</a></li><li><a href='#'>Another action</a></li><li><a href='#'>Something else here</a></li><li role='separator' class='divider'></li><li><a href='#'>Separated link</a></li></ul>" +
                    "</div>" +
                    "</div>";

            var str1 = "<div id='test1' style='position: absolute; border:1px solid red; top: 100px; left: 400px; cursor: pointer'><h2><span class='label label-danger'>root</span></h2></div>";

            var str2 = "<div id='test2' style='position: absolute; border:1px solid red; top: 200px; left: 200px; cursor: pointer'><h3><span class='label label-info'>left1</span></h3></div>";

            var str3 = "<div id='test3' style='position: absolute; border:1px solid red; top: 300px; left: 600px; cursor: pointer'><h3><span class='label label-success'>left2</span></h3></div>";

            var str4 = "<div id='test4' style='position: absolute; border:1px solid red; top: 400px; left: 500px; cursor: pointer'><h3><span class='label label-success'>left2-1</span></h3></div>";

            var str5 = "<div id='test5' style='position: absolute; border:1px solid red; top: 450px; left: 650px; cursor: pointer'><h3><span class='label label-success'>left2-2</span></h3></div>";

            $("#drawingboard_div").append(str);

            $("#drawingboard_div").append(str1);
            $("#drawingboard_div").append(str2);
            $("#drawingboard_div").append(str3);
            $("#drawingboard_div").append(str4);
            $("#drawingboard_div").append(str5);


            $('#test11').draggable({
                containment: "parent"
            });


            $('#test1').draggable({
                containment: "parent",
                drag: function( event, ui ) {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    draw($('#test1'), $('#test2'));
                    draw($('#test1'), $('#test3'));
                    draw($('#test3'), $('#test4'));
                    draw($('#test3'), $('#test5'));
                }
            });
            $('#test2').draggable({
                containment: "parent",
                drag: function( event, ui ) {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    draw($('#test1'), $('#test2'));
                    draw($('#test1'), $('#test3'));
                    draw($('#test3'), $('#test4'));
                    draw($('#test3'), $('#test5'));
                }
            });
            $('#test3').draggable({
                containment: "parent",
                drag: function( event, ui ) {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    draw($('#test1'), $('#test2'));
                    draw($('#test1'), $('#test3'));
                    draw($('#test3'), $('#test4'));
                    draw($('#test3'), $('#test5'));
                }
            });
            $('#test4').draggable({
                containment: "parent",
                drag: function( event, ui ) {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    draw($('#test1'), $('#test2'));
                    draw($('#test1'), $('#test3'));
                    draw($('#test3'), $('#test4'));
                    draw($('#test3'), $('#test5'));
                }
            });
            $('#test5').draggable({
                containment: "parent",
                drag: function( event, ui ) {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    draw($('#test1'), $('#test2'));
                    draw($('#test1'), $('#test3'));
                    draw($('#test3'), $('#test4'));
                    draw($('#test3'), $('#test5'));
                }
            });

            context.clearRect(0, 0, canvas.width, canvas.height);
            draw($('#test1'), $('#test2'));
            draw($('#test1'), $('#test3'));
            draw($('#test3'), $('#test4'));
            draw($('#test3'), $('#test5'));

            $("#modal_add_node").modal("hide");
        }

        function draw(startObj, endObj) {
            var startX = eval($(startObj).css("left").split("px")[0]) + eval($(startObj).css("width").split("px")[0] / 2);
            var startY = eval($(startObj).css("top").split("px")[0]) + eval($(startObj).css("height").split("px")[0] / 2);
            var endX = eval($(endObj).css("left").split("px")[0]) + eval($(endObj).css("width").split("px")[0] / 2);
            var endY = eval($(endObj).css("top").split("px")[0]) + eval($(endObj).css("height").split("px")[0] / 2);

            line(startX, startY, endX, endY);
        }

        function getCanvas() {
            canvas = document.getElementById("canvas_div");
            if (canvas == null) {
                return false;
            }
            context = canvas.getContext("2d");
        }

        function line(startX, startY, endX, endY) {
            context.strokeStyle = "rgb(250,0,0)";
            context.fillStyle = "rgb(250,0,0)";

            context.beginPath();
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);
            context.stroke();
        }

    </script>
</html>