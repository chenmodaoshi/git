<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎来到后台用户管理!</title>
</head>
<body>
	<input type="hidden" id="thisuser" value="${sessionScope.user.pow}"/>
	<div style="margin:20px 0;"></div>
	
	<table id="dg" title="用户管理表">
	</table>
	<div id="tb" style="height:auto">
		<c:if test="${ sessionScope.user.pow==0}">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
		</c:if>
		<a href="javascript:void(0)" id="update" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" >修改</a>
		<a href="javascript:void(0)" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" >查找所有用户</a>
		<a href="javascript:void(0)" id="searchUser" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" >查找用户</a>
		<input type="text" id="petnameSearch" class="textbox">
	</div>
	<input type="hidden" id="powNum" value="${sessionScope.user.pow}"/>
	<input type="hidden" id="modifyUserid"/>
	<div id="modifyUser">
		<p>
			昵&nbsp;&nbsp;&nbsp;&nbsp;称：<input type="text" id="petname" class="textbox">
		</p><br />
		<p>
			密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="text" id="pwd" class="textbox">
		</p><br />
		<p>
			权&nbsp;&nbsp;&nbsp;&nbsp;限：
			<input type="text" id="pow" class="textbox">
			</p><br />
		<p>
			性&nbsp;&nbsp;&nbsp;&nbsp;别：<input type="text" id="sex" class="textbox">
		</p><br />
		<p>
			状&nbsp;&nbsp;&nbsp;&nbsp;态：<input type="text" id="status" class="textbox">
		</p><br />
		<p>手机号码：<input type="text" id="phone" class="textbox"></p>
	</div>
	
	<div id="modifyUserBtn">
		<input type="button" id="rbtn" value="修改"/>
	</div>
	<style type="text/css">
			#modifyUser{
				margin: 0px auto;
				padding:6px 0 0 0;
				text-align: center;
				display: none;
			}
			#modifyUser p {
				height:22px;
				line-height:22px;
				padding:4px 0 0 25px;
			}
			#modifyUser.textbox {
				height:22px;
				padding:0 2px;
			}
			#modifyUserBtn{
				text-align: center;
				display: none;
			}
	</style>
	<script type="text/javascript" src="js/userback.js" ></script>
</body>
</html>