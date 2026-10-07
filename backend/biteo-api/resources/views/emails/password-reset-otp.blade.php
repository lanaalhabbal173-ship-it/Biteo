<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Biteo Password Reset</title>
</head>

<body style="
    margin:0;
    padding:40px 20px;
    background:#F7F1EA;
    font-family:Arial, sans-serif;
">

<div style="
    max-width:520px;
    margin:0 auto;
    background:#ffffff;
    border-radius:24px;
    padding:36px 28px;
    text-align:center;
">

    <div style="
        font-size:42px;
        margin-bottom:12px;
    ">
        ☕
    </div>

    <h2 style="
        margin:0;
        color:#2B1D16;
        font-size:26px;
    ">
        Reset Your Password
    </h2>

    <p style="
        color:#74665D;
        font-size:15px;
        line-height:1.6;
        margin-top:14px;
    ">
        Use the verification code below to reset your Biteo password.
    </p>

    <div style="
        margin:28px 0;
        padding:20px;
        background:#F7F1EA;
        border-radius:18px;
        color:#8B5E3C;
        font-size:34px;
        font-weight:bold;
        letter-spacing:10px;
    ">
        {{ $otp }}
    </div>

    <p style="
        color:#74665D;
        font-size:14px;
        line-height:1.6;
    ">
        This code will expire in 10 minutes.
    </p>

    <p style="
        color:#A08F83;
        font-size:12px;
        margin-top:28px;
    ">
        If you didn’t request a password reset, you can ignore this email.
    </p>

</div>

</body>
</html>