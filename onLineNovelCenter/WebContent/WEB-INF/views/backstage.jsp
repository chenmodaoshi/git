<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<script type="text/javascript" src="easyui/jquery.min.js" ></script>
		<script type="text/javascript" src="easyui/jquery.easyui.min.js" ></script>
		<link rel="stylesheet" href="easyui/themes/default/easyui.css"/>
		<link rel="stylesheet" href="easyui/themes/icon.css"/>
		<link rel="stylesheet" href="css/wu.css" />
		<link rel="stylesheet" href="css/icon.css" />
		<style type="text/css">
			.logo {
				width:180px;
				height:50px;
				line-height:50px;
				text-align:center;
				font-size:20px;
				font-weight:bold;
				float:left;
				color:#fff;
			}
			.logout {
				float:right;
				padding:30px 15px 0 0;
				color:#fff;
			}
			a {
				color:#fff;
				text-decoration:none;
			}
			a:hover {
				text-decoration:underline;
			}
			.form-inline .form-control {
			    display: inline-block;
			    width: auto;
			    vertical-align: middle;
			}
			.form-inline .form-group {
			    display: inline-block;
			    margin-bottom: 0;
			    vertical-align: middle;
			}
			.form-group {
		  	 	margin-bottom: 15px;
			}
			.form-control {
		    display: block;
		    width: 100%;
		    height: 34px;
		    padding: 6px 12px;
		    font-size: 14px;
		    line-height: 1.42857143;
		    color: #555;
		    background-color: #fff;
		    background-image: none;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
		    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
		    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			}
		</style>
		<script type="text/javascript">
			//静态树导航
			var menujson1=[{
				"id":1,
			    "text":"用户管理",
			    "state":"",
			    "iconCls":"icon-user",   
			    "attributes":{
					"url":"backuser",
					"icon":"css/icons/user.png"
				}
			}];
			
			var menujson2=[{
				"id":1,
			    "text":"发布公告",
			    "state":"",
			    "iconCls":"icon-sound",   
			    "attributes":{
					"url":"intoNotice",
					"icon":""
				}
			},
				{
			    	"id":2,
			        "text":"置顶/加精",
			        "state":"",
			        "iconCls":"icon-medal-bronze-1",   
			        "attributes":{
			            "url":"",
			            "icon":""
			     }
			},
				{
			    	"id":3,
			        "text":"帖子管理",
			        "state":"",
			        "iconCls":"icon-edit",   
			        "attributes":{
			            "url":"intoPostManager",
			            "icon":""
			     }
			}];
			
			
			$(document).ready(function(){
				$('#tabs').tabs({
					fit : true,
					border : false,
				});
			  	$("#nav1").tree({
			  		data : menujson1,
					onLoadSuccess : function (node, data) {
						var _this = this;
						if (data) {
							$(data).each(function (index, value) {
								if (this.state == 'closed') {
									$(_this).tree('expandAll');
								}
							});
						}
					},
			  		onClick: function(node){
			  			var _href = node.attributes.url;
			  			//alert(_href)
			  			if (node) {
							if ($('#tabs').tabs('exists', node.text)) {
								$('#tabs').tabs('select', node.text)
							} else {
								$('#tabs').tabs('add', {
									title: node.text,
									closable: true,
									iconCls : node.iconCls,
									href : _href,
								});
							}
						}
			  		}
			  	});
			  	
			  	$("#nav2").tree({
			  		data : menujson2,
			  		onClick: function(node){
			  			var _href = node.attributes.url;
			  			if (node) {
							if ($('#tabs').tabs('exists', node.text)) {
								$('#tabs').tabs('select', node.text)
							} else {
								$('#tabs').tabs('add', {
									title: node.text,
									closable: true,
									iconCls : node.iconCls,
									href : _href,
								});
							}
						}
			  		}
			  	});
				
			});
			//注销
			function logout(){
				$.ajax({
					url :'logoutUser',
					type : 'post',
					dataType: "text",
					success : function(data){
						if(data=='success'){
							location.href = 'index.jsp';
						}else{
							alert("注销失败");
						}
					}
				}); /*onregister-ajax*/
			}
		
		</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',title:'header',split:true,noheader:true" style="height:60px;background:#666;">
			<div class="logo">后台管理</div>
			<div class="logout"><a href="index.jsp" >回到首页</a>
			 | <a href="#" onclick="logout()">注销</a>
			</div>
		</div>
		<div data-options="region:'south',title:'footer',split:true,noheader:true" style="height:35px;line-height:30px;text-align:center;">
			©2009-2015. Powered by JAVA and EasyUI.
		</div>
		 <!-- begin of sidebar -->
		<div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'"> 
    		<div class="easyui-accordion" data-options="border:false,fit:true"> 
	        	<div title="用户管理" data-options="iconCls:'icon-application-cascade'" style="padding:5px;">  	
	    			<ul class="easyui-tree wu-side-tree" id="nav1">
	                </ul>
	            </div>
	            <div title="帖子管理" data-options="iconCls:'icon-application-form-edit'" style="padding:5px;">  	
	    			<ul class="easyui-tree wu-side-tree" id="nav2">
	                </ul>
	            </div>
        	</div>
    	</div>	
    	<!-- end of sidebar -->    
		<div data-options="region:'center'" style="overflow:hidden;">
			<div id="tabs" class="easyui-tabs" data-options="border:false,fit:true">
				<div title=" 起始页" iconCls="icon-house" style="padding:0 10px;display:block;">
					<p>欢迎来到后台管理系统！</p>
				</div>
			</div>
		</div>
	</body>