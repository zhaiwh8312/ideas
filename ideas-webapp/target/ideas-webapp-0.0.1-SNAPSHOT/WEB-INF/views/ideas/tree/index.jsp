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
        </style>
    </head>

    <body>
        <!-- top 菜单 begin -->
        <jsp:include page="/WEB-INF/views/base/top.jsp"/>
        <!-- top 菜单 end -->

        <div class="container">
            <div id="drawingboard_div" class="row row-offcanvas row-offcanvas-right" style="width:100%; height: 1000px; background-color: #EAEAEA; position: relative;">
                <canvas id='canvas_div' height="1000px"></canvas>
                <c:forEach items="${nodeInfoList}" var="node" varStatus="s">
                <div id='node_${node.nodeId}' name='node_button' style='position: absolute; top: ${node.yLocation}px; left: ${node.xLocation}px; cursor: pointer'>
                    <c:choose>
                        <c:when test="${node.parentNodeId == 0}">
                        <a href='javascript:;' class='btn btn-danger btn-block' ondblclick='doAddNodeInit("${node.nodeId}")' role='button'>
                        </c:when>
                        <c:otherwise>
                            <a href='javascript:;' class='btn btn-default btn-block' ondblclick='doAddNodeInit("${node.nodeId}")' role='button'>
                        </c:otherwise>
                    </c:choose>
                        <input type='hidden' id='parent_${node.nodeId}' value='${node.parentNodeId}' />
                        ${node.nodeContent}
                    </a>
                </div>
                </c:forEach>
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
                                <input type="hidden" id="input_idea_id" name="ideaId" value="${ideaInfo.ideaId}"/>
                                <input type="hidden" id="input_parent_id" name="parentId" />
                                <div class="form-group">
                                    <label for="input_node_content">创建节点</label>
                                    <input type="text" class="form-control" id="input_node_content" name="nodeContent" placeholder="内容" required/>
                                </div>
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

            // 画出连接线
            drawAllLine();

            // 每个node设置都可以拖动
            <c:if test="${null != sessionScope.user && sessionScope.user.userId == ideaInfo.userId && fn:length(nodeInfoList) >= 0}">
            $("div[name='node_button']").draggable({
                containment: "parent",
                stop: function( event, ui) {
                    doUpdateLocation($(this).attr("id").split("_")[1], ui.position.left, ui.position.top);
                },
                drag: function( event, ui ) {
                    drawAllLine();
                }
            });
            </c:if>

            $("#addForm").validate({
                onfocusout: function(element) { $(element).valid(); }
            });

            <c:if test="${null != sessionScope.user && sessionScope.user.userId == ideaInfo.userId && fn:length(nodeInfoList) == 0}">
            $("#modal_add_node").modal("show");
            </c:if>
        });

        function getCanvas() {
            canvas = document.getElementById("canvas_div");
            if (canvas == null) {
                return false;
            }
            context = canvas.getContext("2d");
        }

        function doAddNodeInit(nodeId) {
            $("#addForm")[0].reset();

            $("#input_parent_id").val(nodeId);

            $("#modal_add_node").modal("show");
        }

        function doAddNode() {
            if (!$("#addForm").valid()) {
                return;
            }

            var xLocation = 0;
            var yLocation = 0;

            var parentId =  $("#input_parent_id").val();

            if (parentId == null || parentId == "") {
                parentId = 0;
            }

            if (parentId == 0) {
                xLocation = eval(canvas.width / 2);
                yLocation = eval(canvas.height / 2);
            } else {
                xLocation = 100;
                yLocation = 200;
            }

            $.ajax({
                url: "<%=request.getContextPath() %>/idea_node/add.json",  //这里是网址
                type: "POST",
                data:{
                    ideaId : $("#input_idea_id").val(),
                    nodeContent : $("#input_node_content").val(),
                    parentId : parentId,
                    xLocation : xLocation,
                    yLocation : yLocation
                },
                dataType: "json",
                async: true,
                success:function(data){
                    if (data == null) {
                    } else {
                        var str = "";
                        str += "<div id='node_"+data.nodeId+"' name='node_button' style='position: absolute; top: "+data.yLocation+"px; left: "+data.xLocation+"px; cursor: pointer'>";
//                        str += "<div class='btn-group'>";

                        if (data.parentNodeId == 0) {
                            str += "<a href='javascript:;' class='btn btn-danger btn-block' ondblclick='doAddNodeInit("+data.nodeId+")' role='button'>";
                        } else {
                            str += "<a href='javascript:;' class='btn btn-default btn-block' ondblclick='doAddNodeInit("+data.nodeId+")' role='button'>";
                        }
                        str += "<input type='hidden' id='parent_"+data.nodeId+"' value='"+data.parentNodeId+"' />";
                        str += data.nodeContent;
                        str += "</a>";
//                        str += "<ul class='dropdown-menu'><li><a href='#'>Action</a></li><li><a href='#'>Another action</a></li><li><a href='#'>Something else here</a></li><li role='separator' class='divider'></li><li><a href='#'>Separated link</a></li></ul>";
//                        str += "</div>";
                        str += "</div>";

                        $("#drawingboard_div").append(str);

                        $('#node_'+data.nodeId).draggable({
                            containment: "parent",
                            stop: function( event, ui) {
                                doUpdateLocation($(this).attr("id").split("_")[1], ui.position.left, ui.position.top);
                            },
                            drag: function( event, ui ) {
                                drawAllLine();
                            }
                        });

                        drawAllLine();

                        $("#modal_add_node").modal("hide");
                    }
                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function drawAllLine() {
            // 清除画板上所有东西
            context.clearRect(0, 0, canvas.width, canvas.height);

            $("div[name='node_button']").each(function(index, item){
                var id = $(item).attr("id");

                var parentId = $("#parent_" + id.split("_")[1]).val();

                if (parentId == 0 || parentId == "0") {
//                    continue;
                } else {
                    var parentNode = $("#node_"+parentId);

                    drawSingleLine($(parentNode), $(item));
                }
            });
        }

        function drawSingleLine(startObj, endObj) {
            var startX = eval($(startObj).css("left").split("px")[0]) + eval($(startObj).css("width").split("px")[0] / 2);
            var startY = eval($(startObj).css("top").split("px")[0]) + eval($(startObj).css("height").split("px")[0] / 2);
            var endX = eval($(endObj).css("left").split("px")[0]) + eval($(endObj).css("width").split("px")[0] / 2);
            var endY = eval($(endObj).css("top").split("px")[0]) + eval($(endObj).css("height").split("px")[0] / 2);

            context.strokeStyle = "rgb(250,0,0)";
            context.fillStyle = "rgb(250,0,0)";

            context.beginPath();
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);
            context.stroke();
        }

        function doUpdateLocation(nodeId, xLocation, yLocation) {
            $.ajax({
                url: "<%=request.getContextPath() %>/idea_node/update_location.json",  //这里是网址
                type: "POST",
                data:{
                    nodeId : nodeId,
                    xLocation : xLocation,
                    yLocation : yLocation
                },
                dataType: "json",
                async: true,
                success:function(data){

                },
                timeout:30000,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

    </script>
</html>