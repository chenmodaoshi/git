$(function(){
	$("#update").click(function(){
		var $row = $('#dg').datagrid('getSelected');
		var powNum=$('#powNum').val();
		$('#modifyUserid').val($row.userid);
		if($row.length==0){
			return false;
		}
		$("#modifyUser").dialog({
		title:'修改用户',
		width : 300,
		height : 400,
		modal : true,
		iconCls : 'icon-login',
		buttons : '#modifyUserBtn',

		});
		//密码
		$("#pwd").validatebox({
			required:true,
			missingMessage:'请输入密码',
			validType:'length[6,30]',
			invalidMessage:'密码在6-30位',
			
		}).val($row.pwd).attr("readonly",true);
		//昵称
		$("#petname").validatebox({
			required:true,
			missingMessage:'请输入名称，名称大于等于4位',
			validType:'length[4,30]',
			invalidMessage:'名称过短',
			
		}).val($row.petname).attr("readonly",true);
		//性别
		$("#sex").validatebox({
			required:true,
			missingMessage:'请输入性别男或女',
			validType:'sexcheck',
			
		}).val($row.sex).attr("readonly",true);
		//电话
		$("#phone").validatebox({
			required:true,
			missingMessage:'请输入手机号码',
			validType:'phoneNum',
		}).val($row.phone).attr("readonly",true);
		//权限
		if(powNum!=0){
			$("#pow").attr("readonly",true);
		}
		$("#pow").validatebox({
			required:true,
			missingMessage:'请输入权限1为管理员2为普通用户',
			validType:'powNum',
		}).val($row.pow);
		//状态
		$("#status").validatebox({
			required:true,
			missingMessage:'请输入状态,1关小黑屋',
			validType:'statusNum',
		}).val($row.status);
		$("#rbtn").click(function(){
			if (!$('#mname').validatebox('isValid')) {
				$('#mname').focus();
			} else if (!$('#password').validatebox('isValid')) {
				$('#password').focus();
			} else {
				modifyUser();
			}
			
		});
		$.extend($.fn.validatebox.defaults.rules, {
    		sexcheck: {
       			validator: function (value, param) {
       				if(value=='男'|value=='女'){
       					return value;
       				}
       		 	},
        		message: '请输入男或者女',
    		},
    		phoneNum: {
       			validator: function (value, param) {
       				return /^1[34578]\d{9}$/.test(value);
       		 	},
        		message: '请输入正确的手机号',
    		},
    		powNum: {
    			validator: function (value, param) {
       				return /^[12]$/.test(value);
       		 	},
        		message: '只能输入1(管理员)或者2(普通用户)',
    		},
    		statusNum: {
    			validator: function (value, param) {
       				return /^[01]$/.test(value);
       		 	},
        		message: '只能输入0(允许发帖回复)或者1(禁止发帖回复)',
    		},
		});
		$("#modifyUser input").validatebox('enableValidation');
	});
	
	$("#res").click(function(){
		$("#modifyUser input").val(null).validatebox('enableValidation');
		
	});
	
	$("#modifyUserBtn").click(function(){
		if (!$('#pwd').validatebox('isValid')) {
			$('#pwd').focus();
		} else if (!$('#pow').validatebox('isValid')) {
			$('#pow').focus();
		} else{
			modifyUser();
		}
	});
});/* 页面加载结束 */
$("#search").click(function(){
	var thisuser=$("#thisuser").val();
	$('#dg').datagrid({
		url:'showalluser?pow='+thisuser,
		method:'get',
		toolbar: '#tb',
		pagination:true,
		singleSelect: true,
		pageSize:10,
		pageList: [10, 20, 30],
		fitColumns:true, 
		columns : [ [ {
                field : 'userid',title : '编号',width : 48,align : 'center'
            }, {
            	field:'accound',title : '账号',align:'center',width:115,editor:'textbox'
            }, {
            	field:'pwd',title : '密码',align:'center',width:116,editor:'textbox'
            }, {
            	field:'pow',title : '权限',align:'center',width:60,editor:'numberbox'
            }, {
            	field:'regdate',title : '注册时间',align:'center',width:96
            }, {
            	field:'sex',title : '性别',align:'center',width:35,editor:'textbox'
            }, {
            	field:'petname',title : '昵称',align:'center',width:120,editor:'textbox'
            }, {
            	field:'phone',title : '手机号码',align:'center',width:117,editor:'numberbox'
            }, {
            	field:'status',title : '状态',align:'center',width:45,editor:'numberbox'
            } ] ],
	});
	var dg=$('#dg').datagrid('getPager');
});
$("#searchUser").click(function(){
	var thisuser=$("#petnameSearch").val();
	$('#dg').datagrid({
		url:'searchUser?petname='+thisuser,
		method:'get',
		toolbar: '#tb',
		pagination:true,
		singleSelect: true,
		pageSize:10,
		pageList: [10, 20, 30],
		fitColumns:true, 
		columns : [ [ {
                field : 'userid',title : 'Id',width : 48,align : 'center'
            }, {
            	field:'accound',title : 'accound',align:'center',width:115,editor:'textbox'
            }, {
            	field:'pwd',title : 'pwd',align:'center',width:116,editor:'textbox'
            }, {
            	field:'pow',title : 'pwd',align:'center',width:60,editor:'numberbox'
            }, {
            	field:'regdate',title : 'regdate',align:'center',width:96
            }, {
            	field:'sex',title : 'sex',align:'center',width:35,editor:'textbox'
            }, {
            	field:'petname',title : 'petname',align:'center',width:120,editor:'textbox'
            }, {
            	field:'phone',title : 'phone',align:'center',width:117,editor:'numberbox'
            }, {
            	field:'status',title : 'status',align:'center',width:45,editor:'numberbox'
            } ] ],
	});
	var dg=$('#dg').datagrid('getPager');
});
function modifyUser(){
	$.ajax({
		url : 'adminModifyUser',
		type : 'post',
		data : {
			userid : $('#modifyUserid').val(),
			pow : $('#pow').val(),
			status : $('#status').val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : '正在修改...',
			});
		},
		dataType: "text",
		success : function(data, response, status){
			$.messager.progress('close');
			if(data=='success'){
				$("#dg").datagrid('reload');
				alert("修改成功");
			}
		}
	}); 
}
function removeit(){
	var rows = $('#dg').datagrid('getSelections');
	var data = {"userid":rows[0].userid};
	ajax("deleteuser",data);
}

function ajax($url,$data){
	$.ajax({
	    url:$url,    //请求的url地址
	    dataType:"text",   //返回格式为json
	    data:$data,    //参数值
	    type:"GET",   //请求方式
	    beforeSend : function () {
			$.messager.progress({
				text : '正在尝试删除...',
			});
		},
	    success:function(data){
	    	$.messager.progress('close');
	    	$("#dg").datagrid('reload');
	    	alert("删除用户成功！");
	    	endEditing();
	    },
	    error:function(){
	    	$.messager.progress('close');
	    	alert("error");
	    	reject();
	    }
	});
}