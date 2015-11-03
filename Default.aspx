<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="InstaPhotos.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <h1>About Me</h1>
        <div style="font-size: medium;">
            User Name:  
                <label id="usernameLabel">
                </label>
        </div>
        <div style="font-size: medium;">
            Full Name:  
                <label id="nameLabel">
                </label>
        </div>
        <div style="font-size: medium;">
            Profile Pic:  
                <img id="imgProfilePic" />
        </div>
        <div style="font-size: medium;">
            Bio:  
                <label id="bioLabel">
                </label>
        </div>
    </div>

        <div>
            <h1>Recent Photos</h1>
            <div id="PhotosDiv">
                <ul id="PhotosUL">
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>

        <div>
            <h1>Popular Pictures</h1>
            <div id="PopularPhotosDiv">
                <ul id="photosUL1">
                </ul>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            GetUserDetails();
            GetInstagramPhotos();
            GetPopularPhotos();
        });

        //Get user details  
        function GetUserDetails() {
            $.ajax({
                type: "GET",
                async: true,
                contentType: "application/json; charset=utf-8",
                url: 'https://api.instagram.com/v1/users/' + instagramaccessid + '?access_token=' + instagramaccesstoken,
                dataType: "jsonp",
                cache: false,
                beforeSend: function () {
                    $("#loading").show();
                },
                success: function (data) {
                    $('#usernameLabel').text(data.data.username);
                    $('#nameLabel').text(data.data.full_name);
                    $('#bioLabel').text(data.data.bio);
                    document.getElementById("imgProfilePic").src = data.data.profile_picture;
                }
            });
        }

        function GetInstagramPhotos() {
            $("#PhotosUL").html("");
            $.ajax({
                type: "GET",
                async: true,
                contentType: "application/json; charset=utf-8",
                //Recent user photos  
                url: 'https://api.instagram.com/v1/users/' + instagramaccessid + '/media/recent?access_token=' + instagramaccesstoken,
                dataType: "jsonp",
                cache: false,
                beforeSend: function () {
                    $("#loading").show();
                },
                success: function (data) {
                    $("#loading").hide();
                    if (data == "") {
                        $("#PhotosDiv").hide();
                    } else {

                        $("#PhotosDiv").show();
                        for (var i = 0; i < data["data"].length; i++) {
                            $("#PhotosUL").append("<li style='float:left;list-style:none;'><a target='_blank' href='" + data.data[i].link + "'><img src='" + data.data[i].images.thumbnail.url + "'></img></a></li>");
                        }

                    }
                }

            });
        }

        function GetPopularPhotos() {
            $("#photosUL1").html("");
            $.ajax({
                type: "GET",
                async: true,
                contentType: "application/json; charset=utf-8",
                //Most popular photos  
                url: "https://api.instagram.com/v1/media/popular?access_token=" + instagramaccesstoken,
                dataType: "jsonp",
                cache: false,
                beforeSend: function () {
                    $("#loading").show();
                },
                success: function (data) {
                    $("#loading").hide();
                    if (data == "") {
                        $("#PopularPhotosDiv").hide();
                    } else {
                        $("#PopularPhotosDiv").show();
                        for (var i = 0; i < data["data"].length; i++) {
                            $("#photosUL1").append("<li style='float:left;list-style:none;'><a target='_blank' href='" + data.data[i].link + "'><img src='" + data.data[i].images.thumbnail.url + "'></img></a></li>");
                        }

                    }
                }

            });
        }
    </script>
</body>
</html>
