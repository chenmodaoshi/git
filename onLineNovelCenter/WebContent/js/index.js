$(document).ready(function() {
	loadPostByPage(1);
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
   //给搜索框添加跳转搜索结果页事件
	$("#searchBtn").click(function(){
		$("#searchType").val($("#selectType option:selected").val());
        $("#searchForm").attr("action","toSeachPostResultPage");
        $("#searchForm").submit();
	});
	//给搜索框添加跳转搜索结果页事件结束	
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
				location.href = 'index.jsp';
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
				location.href = 'index.jsp';
			}else{
				alert("注销失败");
			}
		}
	}); /*onregister-ajax*/
}
			
function loadPostByPage(pageNum) {
	$.ajax({
			type: "GET",
			url: "loadPostByPage?&requestPageNum=" + pageNum,
			success: function(data) {
				var tbody = "";
				var ptypeHead = "<td><span class='glyphicon glyphicon-eye-open'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
				var ptypeTail = "</a></span></td>";
				var pnameHead = "<td><a href='goScondCommByPostId?postId=";
				var pnameTail = "<a></td>";
				var userHead = "<td><a href='javascript:void(0);'>";
				var userTail = "</a></td>";
				var commhead = "<td>";
				var commTail = "</td>";
				var lastDateHead = "<td>";
				var lastDateTail = "</td>";
				for (var i = 0; i < data[1].length; i++) {
					  if(data[1][i].plevel==0){//公告
						    var ptypeHead = "<td><span class='glyphicon glyphicon-volume-up'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
							tbody += ("<tr id='" + data[1][i].postid + "'>" + 
									ptypeHead +  data[1][i].ptype +ptypeTail +
									pnameHead +data[1][i].postid+"'>"+  data[1][i].pname+pnameTail +
									userHead +  data[1][i].user.petname+userTail +
									commhead + (data[1][i].commnum+"/"+data[1][i].clicknum ) + commTail + 
									lastDateHead + new Date(data[1][i].lastdate).Format('yyyy-MM-dd hh:mm：ss') + lastDateTail + "</tr>"
									);	
					  }
					  if(data[1][i].plevel==1){//加精
						  var ptypeHead = "<td><span class='glyphicon glyphicon-hand-right'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
							tbody += ("<tr id='" + data[1][i].postid + "'>" + 
									ptypeHead +  data[1][i].ptype +ptypeTail +
									pnameHead +data[1][i].postid+"'>"+ data[1][i].pname+"【精华】"+pnameTail +
									userHead +  data[1][i].user.petname+userTail +
									commhead + (data[1][i].commnum+"/"+data[1][i].clicknum )+ commTail + 
									lastDateHead + new Date(data[1][i].lastdate).Format('yyyy-MM-dd hh:mm：ss') + lastDateTail + "</tr>"
									);	
					  }
					  
					  if(data[1][i].plevel==2){//普通
						  var ptypeHead = "<td><span class='glyphicon glyphicon-heart-empty'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
							tbody += ("<tr id='" + data[1][i].postid + "'>" + 
									ptypeHead +  data[1][i].ptype +ptypeTail +
									pnameHead +data[1][i].postid+"'>"+data[1][i].pname+pnameTail +
									userHead +  data[1][i].user.petname+userTail +
									commhead + (data[1][i].commnum+"/"+data[1][i].clicknum ) + commTail + 
									lastDateHead + new Date(data[1][i].lastdate).Format('yyyy-MM-dd hh:mm：ss')+ lastDateTail + "</tr>"
									);	
					  }
					  
					
				}
					
					$("#postList").html(tbody);
					$("#pageNums").html("");
					pageCount = data[0]; //总页数
					
					$("#pageCount").html("总页数："+pageCount);
					$("#pageCount").val(pageCount);
					$("#currentPage").html("当前第"+pageNum+"页");
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
					if (data[0] > 4 && pageNum >= data[0] - 4
							&& pageNum <= data[0]) {
						var n = data[0] - 4;
						for (var num = 0; num < 5; num++) {
							var $li = $("<li><a href='javascript:void(0);'>"
									+ n + "</a></li>");
							//alert($li.children()[0].text)
							$("#pageNums").append($li);
							n = n + 1;
						}
					} else {
						if (data[0] <= 4) {
							pageNum = 1;
						}
						for (var num = 0; num < 5; num++) {
							if (pageNum + num <= pageCount) {
								var $li = $("<li><a href='javascript:void(0);'>"
										+ (pageNum + num)
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
						if (num < data[0] - 3) {
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
								var num = parseInt($(this).text());
								loadPostByPage(num);
							});
				},
				error : function(data) {
					$("#postList").html("請求失敗，請刷新頁面");
				}
			});
	//ajax 结束
	return false;
}
//发布帖子
function publishPost() {

	var ptype = $("#ptype option:selected").val();
	
	var pname = $("#pname").val();
	var content = $("#content").val();
	content=content.replace(/\n|\r\n/g,"<br/>");
	if(ptype.length==0){
		alert("请选择类型");
		return false;
	}
	if(ptype=="请选择类型"){
		alert("请选择类型");
		return false;
	} 
	if(pname.length==0) {
		alert("请输入标题");
		return false;
	}
	if(pname.length>=50){
		alert("标题过长，请限制在50字内");
		return false;
	}
	if(content.length==0){
		alert("请输入内容");
		return false;
	} 
	if(content.length>=800){
		alert("内容过长，请限制在800字内");
		return false;
	}
	var data = {
		ptype : ptype,
		pname : pname,
		content : content
	};

	$.ajax({
		type : "POST",
		url : "publishPost",
		data : data,
		// contentType:"json",
		success : function(data) {
			//新增代码段
			var result = data;
			if (result == "true"){
				  alert("发布帖子成功");
				  
				 $("#ptype option:selected").val("")
				 $("#pname").val("");
				 $("#content").val("");
				 location.href = 'index.jsp';
			}
				
			if (result == "false")
				alert("发布帖子失败,请尝试再发布");
			if (result == "off_line")
				alert("您未登录,请先登录");
			if(result=="forbid")
				alert("您被禁止发帖,详情请咨询管理员!");
			
			//loadPostByPage(1);
			
		},
		error : function(data) {

		}
	});

	return false;
}

//跳转页面
function skipPage(){
	
	var pageNum=$("#pageNum").val();
	
	var checkPageNum =/^-?\d+$/;
	
	var pageCount= $("#pageCount").val();
	
	if(!checkPageNum.test(pageNum)){
		
	}
	else{
		
		if(parseInt(pageNum)>parseInt(pageCount)) 
			;
		else{
			
			loadPostByPage(parseInt(pageNum));
		}
		  
	}

}
//更新js格式化json时间格式
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒  
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}