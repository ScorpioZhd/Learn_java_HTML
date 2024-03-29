<%--
  Created by IntelliJ IDEA.
  User: zhd
  Date: 2018/11/1
  Time: 8:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <meta charset="UTF-8">
    <title>Basic DataGrid - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/jquery-easyui-1.3.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/jquery-easyui-1.3.3/demo/demo.css">
    <script type="text/javascript" src="<%=path%>/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=path%>/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script>
        var url;
        function deleteUser(){
            var row=$('#dg').datagrid('getSelected');
            if(row){
                $.messager.confirm("系统提示","您确定要删除这条记录吗?",function(r){
                    if(r){
                        $.post('userDelete',{delId:row.id},function(result){
                            if(result.success){
                                $.messager.alert("系统提示","已成功删除这条记录!");
                                $("#dg").datagrid("reload");
                            }else{
                                $.messager.alert("系统提示",result.errorMsg);
                            }
                        },'json');
                    }
                });
            }
        }

        function newUser(){
            $("#dlg").dialog('open').dialog('setTitle','添加用户');
            $('#fm').form('clear');
            url='userSave';
        }


        function editUser(){
            var row=$('#dg').datagrid('getSelected');
            if(row){
                $("#dlg").dialog('open').dialog('setTitle','编辑用户');
                $('#fm').form('load',row);
                url='userSave?id='+row.id;
            }
        }


        function saveUser(){
            $('#fm').form('submit',{
                url:url,
                onSubmit:function(){
                    return $(this).form('validate');
                },
                success:function(result){
                    var result=eval('('+result+')');
                    if(result.errorMsg){
                        $.messager.alert("系统提示",result.errorMsg);
                        return;
                    }else{
                        $.messager.alert("系统提示","保存成功");
                        $('#dlg').dialog('close');
                        $("#dg").datagrid("reload");
                    }
                }
            });
        }

    </script>
</head>
<body>
<table id="dg" title="用户管理" class="easyui-datagrid" style="width: auto;height: auto"
       url="student2"
       toolbar="#toolbar" pagination="true"
       rownumbers="true" fitColumns="true" singleSelect="true">
    <thead>
    <tr>
        <th field="id" width="50" hidden="true">编号</th>
        <th field="name" width="50">姓名</th>
        <th field="password" width="50">密码</th>
        <th field="email" width="50">Email</th>
        <th field="remark" width="50">remark</th>
    </tr>
    </thead>
</table>
<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除用户</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:250px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="10px;">
            <tr>
                <td>姓名：</td>
                <td><input name="name" class="easyui-validatebox" required="true" style="width: 200px;"></td>
            </tr>
            <tr>
                <td>联系电话：</td>
                <td><input name="phone" class="easyui-validatebox" required="true" style="width: 200px;"></td>
            </tr>
            <tr>
                <td>Email：</td>
                <td><input name="email" class="easyui-validatebox" validType="email" required="true" style="width: 200px;"></td>
            </tr>
            <tr>
                <td>QQ：</td>
                <td><input name="qq" class="easyui-validatebox" required="true" style="width: 200px;"></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
</div>
</body>
</html>