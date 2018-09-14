<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>AdminLTE 2 | Log in</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="/resources/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
</head>

<body class="login-page">

    <div class="login-box">
        <div class="login-logo">
            <a href="/resources/index2.html"><b>Zerock</b>Project</a>
        </div>

        <!-- /.login-logo -->
        <div class="login-box-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form action="/user/loginPost" method="post">
                <div class="form-group has-feedback">
                    <input type="text" name="uid" class="form-control" placeholder="USER ID" /> <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>

                <div class="form-group has-feedback">
                    <input type="password" name="upw" class="form-control" placeholder="Password" /> <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>

                <div class="row">
                    <div class="col-xs-8">
                        <div class="checkbox icheck">
                            <label><input type="checkbox" name="useCookie">Remember Me</label>
                        </div>
                    </div>

                    <!-- /.col -->
                    <div class="col-xs-4">
                        <button type="submit" class="btn btn-primary btn-block btn-flat">SignIn</button>
                    </div>
                    <!-- /.col -->
                </div>
            </form>
            <a href="#">I forgot my password</a><br> <a href="register.html" class="text-center">Register a new membership</a>
        </div>
        <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->

</body>

</html>