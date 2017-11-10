<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctx = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帖子详情</title>
<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet"
	href="bootstrap-3.3.7-dist//css//bootstrap.min.css">
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css//style_46_common.css">
<link rel="stylesheet" type="text/css"
	href="css//style_46_forum_forumdisplay.css">

<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrapValidator.css" />
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrapValidator.js" ></script>

<script src="js/hm.js" type="text/javascript"></script>
<script src="js/forum.js" type="text/javascript"></script>
<script type="text/javascript" charset="UTF-8" src="js/common_extra.js"></script>

</head>

<script type="text/javascript">
	var $mypetname;
	var $myuserid;
	var $mystatus;
	var $postId;
	var pageCount="${requestScope.postCount}";
	$(function() {
		showComms(1);
		$('#login').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            submitButtons: '#loginbtn',
            fields: {
                accound: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 4,
                            max: 20,
                            message: '用户名长度必须在4到20位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        }
                    }
                },
                pwd: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: '密码长度必须在6到20位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9]+$/,
                            message: '用户名只能包含大写、小写、数字'
                        }
                    }
                }
            }
    	});/* login结束 */
    
		$('#register').bootstrapValidator({
	        message: 'This value is not valid',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        submitButtons: '#registerbtn',
	        fields: {
	            accound: {
	                message: '用户名验证失败',
	                validators: {
	                    notEmpty: {
	                        message: '用户名不能为空'
	                    },
	                    stringLength: {
	                        min: 4,
	                        max: 20,
	                        message: '用户名长度必须在4到20位之间'
	                    },
	                    regexp: {
	                        regexp: /^[a-zA-Z0-9_]+$/,
	                        message: '用户名只能包含大写、小写、数字和下划线'
	                    }
	                }
	            },
	            pwd: {
	                validators: {
	                    notEmpty: {
	                        message: '密码不能为空'
	                    },
	                    stringLength: {
	                        min: 6,
	                        max: 20,
	                        message: '密码长度必须在6到20位之间'
	                    },
	                    regexp: {
	                        regexp: /^[a-zA-Z0-9]+$/,
	                        message: '密码只能包含大写、小写、数字'
	                    }
	                }
	            },
	            pwd2: {
	                validators: {
	                    notEmpty: {
	                        message: '密码不能为空'
	                    },
	                    identical:{
	                    	field:'pwd',
	                    	message:'两次密码输入不一致'
	                    },
	                    regexp: {
	                        regexp: /^[a-zA-Z0-9]+$/,
	                        message: '密码只能包含大写、小写、数字'
	                    }
	                }
	            },
	            petname: {
	                validators: {
	                    notEmpty: {
	                        message: '昵称不能为空'
	                    },
	                    stringLength: {
	                        min: 4,
	                        max: 20,
	                        message: '昵称必须在4到20位之间'
	                    },
	                }
	            },
	            phone: {
	                validators: {
	                    notEmpty: {
	                        message: '手机号码不能为空'
	                    },
	                    regexp: {
	                        regexp: /^1[34578]\d{9}$/,
	                        message: '手机号码有误，请重填'
	                    }
	                }
	            }
	            
	        }
	    });/*注册弹框结束*/	
	});
	
	function onlogin(){
		$('#login').data('bootstrapValidator').validate();
		if(!$('#login').data('bootstrapValidator').isValid()){
			return ;
		}
		$.ajax({
			url : 'loginUser',
			type : 'post',
			data : $("#login").serialize(),
			dataType: "text",
			success : function(data){
				if(data=='success'){
					location.href = 'goScondCommByPostId?postId='+$postId;
				}else if(data=='exist'){
					alert("用户不存在");
				}else{
					alert("密码错误");
				}
			}
		}); /*ajax*/
	}/*onlogin-ending*/

	function onregister(){
		$('#register').data('bootstrapValidator').validate();
		if(!$('#register').data('bootstrapValidator').isValid()){
			return ;
		}
		$.ajax({
			url : 'registerUser',
			type : 'post',
			data : $("#register").serialize(),
			dataType: "text",
			success : function(data){
				if(data=='success'){
					location.href = 'index.jsp';
				}else{
					alert("用户已存在");
				}
			}
		}); /*onregister-ajax*/
	}/*onregister-ending*/

	function logout(){
		$.ajax({
			url : 'logoutUser',
			type : 'post',
			dataType: "text",
			success : function(data){
				if(data=='success'){
					location.href = 'goScondCommByPostId?postId='+$postId;
				}else{
					alert("注销失败");
				}
			}
		}); /*onregister-ajax*/
	}
	
	function showComms(requestPageNum) {
		$postId = "${requestScope.postId}";
		$mypetname ="${sessionScope.user.petname}";
		$myuserid = "${sessionScope.user.userid}";
		$mystatus = "${sessionScope.user.status}";
		$.ajax({
			type : "GET",
			url : "getAllCommByPostId?postId=" + $postId+"&requestPageNum="+requestPageNum,
			success : function(data) {
				tietou(data[0]);
				
				var $table=$("#lou");
				$table.html("");
				for (var i = 0; i < data.length; i++) {			//循环5次
					var $table=$("#lou");
				
					$table.append(toBeADiv(data[i]));	
				}

				$("#pageNums").html("");//清空分页导航条
				$("#pageCount").val(pageCount);

				$("#pageCount").html("总页数："+$("#pageCount").val());
				

				$("#currentPage").html("当前第"+requestPageNum+"页");
				// $("#pageNums")
				var $navHead = $("<li><a href='javascript:void(0);'>&laquo;</a></li>");
				$navHead.click(function() {
					var lis = $("#pageNums a").not(":first")
							.not(":last");
					var num = parseInt($(lis[0]).text());
					if (num >= 2) {
						$(lis[0]).text(num - 1);
						$(lis[1]).text(num);
						$(lis[2]).text(num + 1);
						$(lis[3]).text(num + 2);
						$(lis[4]).text(num + 3);
					}
				})
				$("#pageNums").append($navHead);
				if (pageCount> 4 && requestPageNum >= pageCount - 4
						&& requestPageNum <= pageCount) {
					var n = pageCount - 4;
					for (var num = 0; num < 5; num++) {
						var $li = $("<li><a href='javascript:void(0);'>"
								+ n + "</a></li>");
						
						$("#pageNums").append($li);
						n = n + 1;
					}
				} else {
					if (pageCount <= 4) {
						requestPageNum = 1;
					}
					for (var num = 0; num < 5; num++) {
						if (requestPageNum + num <= pageCount) {
							var $li = $("<li><a href='javascript:void(0);'>"
									+ (requestPageNum + num)
									+ "</a></li>");
							//alert($li.children()[0].text)
							$("#pageNums").append($li);
						}
					}
				}
				var $navTail = $("<li><a href='javascript:void(0);'>&raquo;</a></li>");
				$navTail.click(function() {
					var lis = $("#pageNums a").not(":first")
							.not(":last");
					var num = parseInt($(lis[1]).text());
					if (num < pageCount - 3) {
						$(lis[0]).text(num);
						$(lis[1]).text(num + 1);
						$(lis[2]).text(num + 2);
						$(lis[3]).text(num + 3);
						$(lis[4]).text(num + 4);
					}
				})
				$("#pageNums").append($navTail);
				$("#pageNums a").not(":first").not(":last")
						.click(function() {
							var requestPageNum = parseInt($(this).text());
							showComms(requestPageNum);
						});
				
			},
			error : function(data) {
				alert("error show");
			}
		});
	};

	function tietou(com) {
		var $div = $('#tietou');
		$div.html("");
		var $divl = $('<div style="width: 18%;float: left;height: 50px;" class="panel panel-heading">');
		var $pl = $('<p style="margin-left: 9px;margin-top: 5px;font-family: verdana, sans-serif;font-size: 12px;font-weight: bold;line-height: 1.2;"></p>');
		$pl.html("回复"+com.post.commnum+"/查看"+com.post.clicknum+"");
		$divl.append($pl);

		var $divr = $('<div style="width: 82%;float: right;" class="panel panel-body">');
		var $pr = $('<p style="font-family: verdana, sans-serif;font-size: 12px;font-weight: bold;line-height: 1.2;"></p>');
		$pr.html("【" + com.post.ptype + "】" + com.post.pname);
		$divr.append($pr);

		$div.append($divl).append($divr);
	};



	//将帖子的评论信息列出来    楼
	function toBeADiv(com) {
		var $tr=$('<tr></tr>');
		var $td1=$('<td style="background-color: rgb(245,245,245);width: 18%;"></td>');
		var $h2=$('<h2 style="padding-left: 20px;padding-top: 10px;"></h2>');
		$h2.html("【  楼   " + com.floor + "  】"+com.user.petname);
		$img=$('<img src="'+com.user.head+'" style="width: 70%;margin-left: 20px;margin-top: 40px;outline:#ffffff  solid 7px;outline-offset: 1px;" class="img-thumbnail" />');
		$td1.append($h2).append($img);
		
		var $td2=$('<td style="background-color: #FFFFFF;"></td>');
		$td2.html(com.content);
		var $hr=$('<hr style="height:1px;border:none;border-top: dotted;margin-bottom: 9px;" />');
		var $div=$('<div class="form-inline" align="right"></div>');
		var $a1=$('<a href="#"></a>');
		$a1.html("发表时间"+ getDateStr(com.pubdate));
		var $a2 = $('	<a href="#" class="glyphicon glyphicon-thumbs-up" style="color: rgb(255, 201, 188);">支持</a>&nbsp');
		var $a3 = $('<a href="#" class="glyphicon glyphicon-thumbs-down" style="color: rgb(106, 116, 118);">反对</a>&nbsp');
		var $a4 = $('<a href="javascript:void(0)"  class="glyphicon glyphicon-globe" style="color: rgb(77, 62, 189);" onclick="showbox($(this))">回复</a>');

		$div.append($a1).append($a2).append($a3).append($a4);
		$td2.append($hr).append($div);
		$tr.append($td1).append($td2);
		
		//if (com.parent != "") {
			var $request = toBeARequest(com); //本层楼的用户id，回复此用户的孩子parent		//not null 传2次
			$div.append($request);
		//}else {
			
		//}
		return $tr;
	};
	function toBeADiv2(com) {
		var $tr=$('<tr></tr>');
		var $td1=$('<td style="background-color: rgb(245,245,245);width: 18%;"></td>');
		var $h2=$('<h2 style="padding-left: 20px;padding-top: 10px;"></h2>');
		$h2.html("【  楼   " + com.floor + "  】"+com.user.petname);
		$img=$('<img src="'+com.user.head+'" style="width: 70%;margin-left: 20px;margin-top: 40px;outline:#ffffff  solid 7px;outline-offset: 1px;" class="img-thumbnail" />');
		$td1.append($h2).append($img);
		var $td2=$('<td style="background-color: #FFFFFF;"></td>');
		$td2.html(com.content);
		var $hr=$('<hr style="height:1px;border:none;border-top: dotted;margin-bottom: 9px;" />');
		var $div=$('<div class="form-inline" align="right"></div>');
		var $a1=$('<a href="#"></a>');
		$a1.html("发表时间"+ getDateStr(com.pubdate));
		var $a2 = $('	<a href="#" class="glyphicon glyphicon-thumbs-up" style="color: rgb(255, 201, 188);">支持</a>&nbsp');
		var $a3 = $('<a href="#" class="glyphicon glyphicon-thumbs-down" style="color: rgb(106, 116, 118);">反对</a>&nbsp');
		var $a4 = $('<a href="#"  class="glyphicon glyphicon-globe" style="color: rgb(77, 62, 189);" onclick="showbox($(this))">回复</a>');
		$div.append($a1).append($a2).append($a3).append($a4);
		$td2.append($hr).append($div);
		$tr.append($td1).append($td2);
		return $tr;
	};
	
	function showbox(button){
		$targe = button.next().children().children().children().children(".huifu2");
		$targe.prevAll(":even").css('display','none');
		$targe.slideToggle("slow");
		return false;
	}
	//1楼 回复
	function toBeARequest(com) {			
		var $div1 = $('<div class="panel panel-default" class="pl" style="width: 95%;"></div>');
		var $div2 = $('<div id="collapseOne" class="panel-collapse collapse in "></div>');
		var $table = $('<table class="table" style=" background: #FFFFF0;"></table>');			
		if(com.parent!=null){
			var  str2 = trInComm(com);				//传2次
			//alert("str2:  "+str2);
			$table.append(str2);
		}
		var  $str1=	"<tr class='huifu2' style='display:none' >"
			+'<td colspan="3">'					
				+'<textarea id="txt" class="form-control" rows="3" placeholder="回复: '+com.user.petname+'" style="width: 100%;"></textarea>'
				//+'<p align="right"><button type="button" class="btn btn-info  btn-xs" onclick=savehuifu($(this),"'+$myuserid+'","'+com.floor+'","'+com.post.postid+'","'+com.commid+'","'+com.parent[i].user.petname+'","'+$mypetname+'")>提交</button></p>'
				+'<p align="right"><button type="button" class="btn btn-info  btn-xs" onclick=savehuifu($(this),"'+$myuserid+'","'+com.floor+'","'+com.post.postid+'","'+com.commid+'","'+com.user.petname+'","'+$mypetname+'")>提交</button></p>'					
				+'</td>'
			+'</tr>';
		$table.append($str1);
		$div2.append($table);
		$div1.append($div2);
		return $div1;
	};
	
	//回复 循环tr
	function trInComm(com) {
		var str="";
		for(var i = 0; i < com.parent.length; i++){
			 str = str+ "<tr>" 
							+ "<td >" 
								+ com.parent[i].user.petname + " 回复   "+ com.user.petname +" : "+ com.parent[i].content
							+ "</td>" 
								+ "<hr style='margin: 0;border: none;'/>"
							+ "<td>"
								+"<p align='right'>" +getDateStr( com.parent[i].pubdate) + "&nbsp&nbsp<input type='button' value='回复' class='a btn-info  btn-xs' onclick=showtextarea($(this))></p>"
							+ "</td>" 
						+ "</tr>"
						+"<tr class='huifu' style='display:none'>"
				  			+'<td colspan="3">'					
								+'<textarea id="txt" class="form-control" rows="3" placeholder="回复: '+com.parent[i].user.petname+'" style="width: 100%;"></textarea>'
								+'<p align="right"><button type="button" class="btn btn-info  btn-xs" onclick=savehuifu($(this),"'+$myuserid+'","'+com.floor+'","'+com.post.postid+'","'+com.commid+'","'+com.parent[i].user.petname+'","'+$mypetname+'")>提交</button></p>'
							+'</td>'
						+'</tr>';
			 if (com.parent[i].parent != "") {
				str=str+trInComm( com.parent[i]);
			}
		}
		return str;
	};
	
	function showtextarea(button){
		$textarea=button.parent().parent().parent().next();
		$textarea.parent().children().last().css('display','none');
		$textarea.prevAll(":odd").css('display','none');
		$textarea.nextAll(":odd").css('display','none');
		$textarea.slideToggle("slow");
		return false;
	}
	
	
	//无用 点击回复 没法隐藏回复
	function savehuifu (button,userid,floor,postid,parent,fapetname,petname){
		if($myuserid == null ||$myuserid == ""){
			alert("请先登陆!");
			return false;
		}
		if($mystatus == 1){
			alert("无该权限!");
			return false;
		}
		$txtarea=button.parent().prev();
		var content=$txtarea.val();
		if(content.length>=100){
			alert("回复过长，请限制在100字内");
			return false;
		}
		$target = button.parent().parent().parent();
		var str={
				"user.userid":userid,
				"post.postid":postid,
				"parentid":parent,
				"floor":floor,
				"content":$txtarea.val()
				};
		$.ajax({
			type : "post",
			url : "saveanswer",
			async : true,
			data : str, //提交的数据  是form提交的内容
			success : function(data) { //data是返回的数据 是从contorller返回的数据
				 str = "<tr>" 
							+ "<td >" 
								+ petname + " 回复   "+ fapetname +" : "+ $txtarea.val()
							+ "</td>" 
								+ "<hr style='margin: 0;border: none;'/>"
							+ "<td>"
								+"<p align='right'>" +getDateStr(new Date()) + "&nbsp&nbsp<input type='button' value='回复' class='a btn-info  btn-xs' onclick=showtextarea($(this))></p>"
							+ "</td>" 
						+ "</tr>"
						+ "<tr class='huifu' style='display:none'>"
				  			+ '<td colspan="3">'					
								+'<textarea id="txt" class="form-control" rows="3" placeholder="回复: '+petname+'" style="width: 100%;"></textarea>'
								+'<p align="right"><button type="button" class="btn btn-info  btn-xs" onclick=savehuifu($(this),"'+$myuserid+'","'+data.floor+'","'+data.post.postid+'","'+data.commid+'","'+$mypetname+'","'+$mypetname+'")>提交</button></p>'
							+ '</td>'
						+ '</tr>';
					$target.css("display","none");
					var classname=$target.attr("class");
					if(classname=='huifu2'){
						$target.before(str);
					}else{
						$target.after(str);
					}
			},
			error : function(data) {
				alert("error");
			}
		});
		return false;
	}
	
					
	//跳转页面
	function skipPage(){
		
		var requestPageNum=$("#pageNum").val();
		
		var checkPageNum =/^-?\d+$/;
		
		var pageCount= $("#pageCount").val();
       
		if(!checkPageNum.test(requestPageNum)){
			
		}
		else{
			
			if(parseInt(requestPageNum)>parseInt(pageCount)) 
				;
			else{
				
				 showComms(parseInt(requestPageNum));
			}
			  
		}

	}
	//转换时间格式
	function getDateStr(str) {
		var strDate = new Date(str);
		var sDate = strDate.toLocaleString().split(' ')[0];
		return sDate.replace(/年|月/g, '-').replace(/日/g, '');
	}
	
	
	
	
	
</script>


<body
	style="background: url(img/22.jpg) no-repeat fixed 50% 0; background-size: 100% 100%;">

	<div style="width: 71.3%; margin: 0 auto;">

		<!--头部＋导航＋搜索
            	时间：2017-07-27
            -->
		<div class="t9_top" style="width: 920px;">
			<div id="hd">
				<div class="wp">
					<!--注册/登录
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：欢迎注册/登录
           -->
					<div class="hdc cl">
						<h2>
							<a href="#" title="萌动动漫论坛"><img src="img/logo.png"
								alt="萌动动漫论坛" border="0"></a>
						</h2>
						<script src="js/logging.js" type="text/javascript"></script>
							<div class="fastlg cl">
								<div class="y pns">
									<table cellspacing="0" cellpadding="0">
										<tbody>
											<tr>
												<c:if test="${empty sessionScope.user}">
													<td class="fastlg_l">
														<!-- 按钮触发模态框 -->
														<button class="btn btn-primary" data-toggle="modal" data-target="#lmodal">
															登录
														</button>
														<!-- 模态框（Modal） -->
														<div class="modal fade" id="lmodal">
															<div class="modal-dialog" style="width: 300px;">
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																		X
																		</button>
																		<h4 class="modal-title" id="myModalLabel">
																			欢迎登录
																		</h4>
																	</div>
																	<div class="modal-body">
																		<form id="login">
																            <div class="form-group">
																                <label>账号</label>
																                <input type="text" class="form-control" id="accound" name="accound"/>
																            </div>
																            <div class="form-group">
																                <label>密码</label>
																                <input type="password" class="form-control" id="pwd" name="pwd"/>
																            </div>
																            <div class="form-group" style="text-align: center;">
																	            <button type="button" class="btn btn-default" data-dismiss="modal">取消
																				</button>
																				<button type="button" class="btn btn-primary" id="loginbtn" onclick="onlogin();">
																				登录
																				</button>
																			</div>
																        </form>
																	</div>
																</div><!-- /.modal-content -->
															</div><!-- /.modal-dailog -->
														</div><!-- /.modal -->
													</td>
													<td>
														<!-- 按钮触发模态框 -->
														<button class="btn btn-primary" data-toggle="modal" data-target="#rmodal">
															注册
														</button>
														<!-- 模态框（Modal） -->
														<div class="modal fade" id="rmodal">
															<div class="modal-dialog" style="width: 300px;">
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
																		X
																		</button>
																		<h4 class="modal-title" id="myModalLabel">
																			欢迎注册
																		</h4>
																	</div>
																	<div class="modal-body">
																		<form id="register">
																            <div class="form-group">
																                <label>账号</label>
																                <input type="text" class="form-control" name="accound"/>
																            </div>
																            <div class="form-group">
																                <label>密码</label>
																                <input type="password" class="form-control" name="pwd"/>
																            </div>
																            <div class="form-group">
																                <label>确认密码</label>
																                <input type="password" class="form-control" name="pwd2"/>
																            </div>
																            <div class="form-group">
																                <label>昵称</label>
																                <input type="text" class="form-control" name="petname"/>
																            </div>
																            <div class="form-group">
																                <label>性别</label>
																                <select class="form-control" name="sex">
																				  <option>男</option>
																				  <option>女</option>
																				</select>
																            </div>
																            <div class="form-group">
																                <label>手机号码</label>
																                <input type="text" class="form-control" name="phone"/>
																            </div>
																            <div class="form-group" style="text-align: center;">
																	            <button type="button" class="btn btn-default" data-dismiss="modal">取消
																				</button>
																				<button type="button" class="btn btn-primary" id="registerbtn" onclick="onregister();">
																				注册
																				</button>
																			</div>
																        </form>
																	</div>
																</div><!-- /.modal-content -->
															</div><!-- /.modal-dailog -->
														</div><!-- /.modal -->
													</td>
												</c:if>
												<c:if test="${!empty sessionScope.user}">
													欢迎！<a href="myuser" style="font-size:18px;">${sessionScope.user.petname}</a>&nbsp;&nbsp;|
													<button type="button" class="btn btn-primary" onclick="logout();">
													注销
													</button>
												</c:if>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
					</div>

					<!--导航栏
                    	作者：763265137@qq.com
                    	时间：2017-07-27
                    	描述：导航栏
                    -->
					<div id="nv">
						<a href="javascript:;" id="qmenu"
							onmouseover="delayShow(this, function () {showMenu({'ctrlid':'qmenu','pos':'34!','ctrlclass':'a','duration':2});showForummenu(45);})"
							initialized="true" class="">快捷导航</a>
						<ul>
							<li class="a" id="mn_forum"><a href="index.jsp" hidefocus="true">萌首页</a></li>
								<li id="mn_N1771"><a href="toSeachPostResultPage?searchType=请选择类型&keyword=" hidefocus="true">萌搜搜索</a></li>
								<c:if test="${!empty sessionScope.user}">
									<li id="mn_Na033"><a href="myuser" hidefocus="true">个人信息</a></li>
								</c:if>
								<li id="mn_N2d81"><a href="toSeachPostResultPage?searchType=动漫音乐&keyword=" hidefocus="true">动漫音乐</a></li>
								<li id="mn_N7b38"><a href="toSeachPostResultPage?searchType=游戏之声&keyword=" hidefocus="true">游戏之声</a></li>
								<li id="mn_Nbda6"><a href="toSeachPostResultPage?searchType=动画之家&keyword=" hidefocus="true">动画之家</a></li>
								<li id="mn_Na3de"><a href="toSeachPostResultPage?searchType=小说分享&keyword=" hidefocus="true">小说分享</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<br />

		<!--贴名      -->
		<div id="tietou" class="panel panel-default" style="height: 50px;width:960px;">

		</div>



		<!--楼主-->
		<div id="div" style="width:960px;">
			<table class="table" id="lou">
			</table>
		</div>
		
	


		<!--发新帖 按钮
            	作者：763265137@qq.com
            	时间：2017-07-27
            	描述：发新帖1
            -->
		<div class="panel panel-default"
			style="background: 80% 10%; height: 50px; width:960px; padding: 10px;">
             
				<span id="page2" style="float: right;">
				      <button type="button" class="btn" style="margin-top: 0px;float:left;" >第</button>
				      <input id="pageNum" type="text" class="form-control" placeholder="页码" style="margin-top:0px;width:60px;float:left">
				      <button type="button" class="btn" style="margin-top: 0px;float:left;" >页</button>
				      
				     <button type="button" class="btn" style="margin-top: -60px;" onclick="skipPage()">跳转</button>
				     <ul id="pageNums" class="pagination " style="margin-top: 0px; margin-left: 0px;">
				     
				      </ul>
				     <button id="pageCount"type="button" class="btn" style="margin-top: 0px;float:right;" >总页数</button>
				     <button id="currentPage"type="button" class="btn" style="margin-top: 0px;float:right;" >当前页</button>
			   </span>
		
		</div>

		<!-- 盖楼-->
		<div class="panel panel-default" style="height: 200px;width:960px;">
			<form id="formComm" role="form">
				<div style="width: 18%; float: left; height: 200px;" class="panel panel-heading">
					努力盖楼<br /> 
					<input name="user.userid" id="user.userid" value="${sessionScope.user.userid}" style="display:none"/> <br /> 
					<input name="post.postid" id="post.postid" value="${requestScope.postId}" style="display:none"/>
					<br />
				</div>
				<div style="width: 82%; float: right; height: 200px;"
					class="panel panel-body">

					<div class="form-group" style="margin-top: 10px;">
						<textarea name="content" id="content" class="form-control" rows="3" placeholder="请输入盖楼评论"></textarea>
					</div>
					<button id="addCommS" class="btn btn-info">提交</button>


				</div>
			</form>
		</div>
		<script type="text/javascript">
			$("#addCommS").click(function() {
				if($myuserid == null ||$myuserid == ""){
					alert("请先登陆");
					return false;
				}
				if($mystatus == 1){
					alert("无该权限");
					return false;
				}
				
				var content = $("#content").val();
				if(content.length>=800){
					alert("内容过长，请限制在800字内");
					return false;
				}
				content=content.replace(/\n|\r\n/g,"<br/>");
				$("#content").val(content);
				$form = $("#formComm").serialize();
				$.ajax({
					type : "post",
					url : "addComm",
					async : true,
					data : $form, //提交的数据  是form提交的内容
					success : function(data) { //data是返回的数据 是从contorller返回的数据
						//var $table=$("#lou");
						pageCount=data;
						showComms(data);
						$("#content").val("");
					},
					error : function(data) {
						alert("comm error");
					}
				});
				return false;
			});
		</script>
        
		<!-- 页脚 -->
		<div style="margin-left: -15px;">
			<p class="navbar-text navbar-left">© 2001-2013 Comsenz Inc.
				Powered by ABBS! X3.3 Designed by Z.cn</p>
			<p class="navbar-text navbar-right">手机版|ABBS动漫论坛 ( 粤ICP备16666601号</p>
		</div>

	</div>
	<!--最后一个div-->


</body>
</html>