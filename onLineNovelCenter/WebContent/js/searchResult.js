$(document).ready(function() {
	//$("#searchType option:selected").val($("#searchType").val());
	$("#nav_requestPageNum").val($("#requestPageNum").val());
	//alert($("#searchType").val());
	//alert($("#searchType_search").find("option[text='动漫音乐'").text());
	//$("#searchType_search").find("option[text='"+$("#searchType").val()+"']").attr("selected",true);
	//$("#searchType_search option:selected").val($("#searchType").val());
	
	
	
	searchPostFirstPageByPtypeAndPname();
    
	
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
                        message: '用户名只能包含大写、小写、数字'
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

//获取第一页搜索结果
function searchPostFirstPageByPtypeAndPname(){


	$("#nav_searchType").val($("#searchType").val());
	$("#nav_keyword").val($("#keyword").val());		
	$("#nav_requestPageNum").val($("#requestPageNum").val());
	
	$.ajax({
		url : "seachPostByPtypeAndPname",
		type : "GET",
		data : $("#searchForm").serialize(),
		success : function(data){
			reproducePageNavAndResultView(data[0],data[1]);
		},
	    error:function(data){}
	}); /*ajax*/
	return false;
}
//重新搜索获取第一页
function clickSearchPostFirstPageByPtypeAndPname(){


	$("#nav_searchType").val($("#searchType").val());
	$("#nav_keyword").val($("#keyword").val());		
	$("#nav_requestPageNum").val($("#requestPageNum").val());
	$("#searchType").val($("#searchType_search option:selected").val())
	$.ajax({
		url : "seachPostByPtypeAndPname",
		type : "GET",
		data : $("#searchForm").serialize(),
		success : function(data){
			
			reproducePageNavAndResultView(data[0],data[1]);
		},
	    error:function(data){}
	}); /*ajax*/
		return false;
	}  
 
 
 
 
   
   //重现分页导航及结果视图
function reproducePageNavAndResultView(pageCount,pList){
  
	$("#pageCount").text(pageCount);//保存总页数到页面使用
	
	$("#nav").html("");//清空分页导航条
    //重现导航条
	var preBtn=$("");
	//上一页处理
	$("#nav").append($("<li><a href='javascript:void(0)' >上一页</a></li>"));//上一页
	$("#nav >li:first-child").click(function(){
		var oldPageNum=parseInt($("#nav_requestPageNum").val());
		var requestPageNum=parseInt($("#nav_requestPageNum").val())-1;
		if(requestPageNum>=1){
			$("#nav_searchType").val($("#searchType").val());
			$("#nav_keyword").val($("#keyword").val());		
			$("#nav_requestPageNum").val(requestPageNum);
			$.ajax({
				url : "seachPostByPtypeAndPname",
				type : "GET",
				data : $("#nav_form").serialize(),
				success : function(data){
					reproducePageNavAndResultView(data[0],data[1]);
				},
			    error:function(data){
			    	$("#nav_requestPageNum").val(oldPageNum);
			    }
			}); /*ajax*/
			;
		}
		return false
	});//上一页处理结束
	
	if(pageCount<=5){ //总页数少于5
	    for(var i=1;i<=pageCount;i++){
	    	var pageA=$("<a href='javascript:void(0)'onclick='skipSearchResultPage(this)'></a>");
	    	pageA.text(i);
	    	var pageLi=$("<li></li>");
	    	pageLi.append(pageA);
	    	$("#nav").append(pageLi);
	    }
	}
	else{//总页数大等于于5
		
	   var  currentPageNum=$("#nav_requestPageNum").val();
	   currentPageNum=parseInt(currentPageNum);
	   if(currentPageNum+4>pageCount){
		   var distance=pageCount-currentPageNum;
		   if(distance==3) currentPageNum-=1;//3 -1
		   if(distance==2) currentPageNum-=2;//2 -2
		   if(distance==1) currentPageNum-=3;// 1 -3
		   if(distance==0) currentPageNum-=4;// 1 -3
		   for(var i=0;currentPageNum+i<=pageCount;i++){
			   var pageA=$("<a href='javascript:void(0)'onclick='skipSearchResultPage(this)'></a>"); 
			   pageA.text(currentPageNum+i);
			   var pageLi=$("<li></li>");
		       pageLi.append(pageA);
		       $("#nav").append(pageLi);
				   }
   
			   }	 
		       else{
		    	  for(var i=0;i<5;i++){
				    	 var pageA=$("<a href='javascript:void(0)'onclick='skipSearchResultPage(this)'></a>"); 
		    	 if(currentPageNum+i<=pageCount){
                        pageA.text(currentPageNum+i);			    	
				    	var pageLi=$("<li></li>");
				    	pageLi.append(pageA);
				    	$("#nav").append(pageLi);
			    	}
		    	 }
	    }
	}
	//下一页 处理
	 $("#nav").append($("<li><a href='javascript:void(0)'>下一页</a></li>"));//下一页 
	 $("#nav >li:last-child").click(function(){
		     var oldPageNum=parseInt($("#nav_requestPageNum").val());
			var requestPageNum=parseInt($("#nav_requestPageNum").val())+1;
			if(requestPageNum<=pageCount){
				$("#nav_searchType").val($("#searchType").val());
				$("#nav_keyword").val($("#keyword").val());	
				$("#nav_requestPageNum").val(requestPageNum);
				$.ajax({
					url : "seachPostByPtypeAndPname",
					type : "GET",
					data : $("#nav_form").serialize(),
					success : function(data){
						
						reproducePageNavAndResultView(data[0],data[1]);
					},
				    error:function(data){
				    	$("#nav_requestPageNum").val(oldPageNum);
				    }
				}); /*ajax*/
				;
			}
			
			return false
		});//下一页 处理结束
		$("#nav_requestPageNum_skip").val($("#nav_requestPageNum").val());
	//重现导航条结束
	
	
	//重现结果视图
	$("#resultView").html("")//清空包装结果容器
	
	var result = "";
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
	for (var i = 0; i < pList.length; i++) {
		  if(pList[i].plevel==0){//公告
			    var ptypeHead = "<td><span class='glyphicon glyphicon-volume-up'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
			    result += ("<tr id='" + pList[i].postid + "'>" + 
						ptypeHead +  pList[i].ptype +ptypeTail +
						pnameHead +pList[i].postid+"'>"+  pList[i].pname+pnameTail +
						userHead +  pList[i].user.petname+userTail +
						commhead + (pList[i].commnum+"/"+pList[i].clicknum ) + commTail + 
						lastDateHead + new Date(pList[i].lastdate).Format('yyyy-MM-dd hh:mm：ss') + lastDateTail + "</tr>"
						);	
		  }
		  if(pList[i].plevel==1){//加精
			  var ptypeHead = "<td><span class='glyphicon glyphicon-hand-right'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
			  result += ("<tr id='" + pList[i].postid + "'>" + 
						ptypeHead +  pList[i].ptype +ptypeTail +
						pnameHead +pList[i].postid+"'>"+  pList[i].pname+pnameTail +
						userHead +  pList[i].user.petname+userTail +
						commhead + (pList[i].commnum+"/"+pList[i].clicknum ) + commTail + 
						lastDateHead + new Date(pList[i].lastdate).Format('yyyy-MM-dd hh:mm：ss') + lastDateTail + "</tr>"
						);	
		  }
		  
		  if(pList[i].plevel==2){//普通
			  var ptypeHead = "<td><span class='glyphicon glyphicon-heart-empty'style='color: rgb(111, 97, 156);'> <a href='javascript:void(0)'>";
			  result += ("<tr id='" + pList[i].postid + "'>" + 
						ptypeHead +  pList[i].ptype +ptypeTail +
						pnameHead +pList[i].postid+"'>"+  pList[i].pname+pnameTail +
						userHead +  pList[i].user.petname+userTail +
						commhead + (pList[i].commnum+"/"+pList[i].clicknum ) + commTail + 
						lastDateHead + new Date(pList[i].lastdate).Format('yyyy-MM-dd hh:mm：ss') + lastDateTail + "</tr>"
						);		
		  }
		  
		
	}
		
		$("#resultView").html(result);
	//重现结果视图结束
}	
//跳转页面
function skipSearchResultPage(obj){
	
	$("#nav_searchType").val($("#searchType").val());
	$("#nav_keyword").val($("#keyword").val());		
	$("#nav_requestPageNum").val(obj.text);
	$.ajax({
		url : "seachPostByPtypeAndPname",
		type : "GET",
		data : $("#nav_form").serialize(),
		success : function(data){
			
			reproducePageNavAndResultView(data[0],data[1]);
		},
	    error:function(data){}
	}); /*ajax*/
	return false;
	
}	


//任意跳转页面
function skipPageAtWill(){
	var requestPageNum=parseInt($("#nav_requestPageNum_skip").val());//还没检查数据是否都为数字  
	var pageCount=parseInt($("#pageCount").text());

	
	var checkPageNum = /^-?\d+$/;
	if(checkPageNum.test(requestPageNum)){
		if(requestPageNum<=pageCount){
			$("#nav_requestPageNum").val($("#nav_requestPageNum_skip").val());
			$.ajax({
				url : "seachPostByPtypeAndPname",
				type : "GET",
				data : $("#nav_form").serialize(),
				success : function(data){
					
					reproducePageNavAndResultView(data[0],data[1]);
				},
			    error:function(data){}
			}); /*ajax*/
		}
		else
			$("#nav_requestPageNum_skip").val($("#nav_requestPageNum").val());
	}
	else 
		alert("请输入数字");
	return false;
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