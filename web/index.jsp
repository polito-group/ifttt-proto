<%--
  Created by IntelliJ IDEA.
  User: kazuhira
  Date: 22/07/16
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app="iftttApp">
  <head>
    <title>IFTTT Polito</title>

    <!-- JavaScript Libraries -->
    <script src="bower_components/jquery/dist/jquery.js"></script>
    <script src="bower_components/angular/angular.js"></script>
    <script src="bower_components/angular-route/angular-route.js"></script>
    <script src="bower_components/bootstrap/dist/js/bootstrap.js"></script>
    <script src="bower_components/notifyjs/dist/notify.js"></script>
    <script src="scripts/engine.js"></script>


    <!-- Cascade Style Sheets -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap-theme.css">
    <link rel="stylesheet" href="stylesheets/2-col-portfolio.css">
    <link rel="stylesheet" href="stylesheets/index.css">
    <link rel="stylesheet" href="stylesheets/loginPage.css">

  </head>
  <body ng-controller="indexController">

  <!-- TOP NAVBAR BEGIN -->
  <nav class="navbar navbar-inverse navbar-fixed-top navbar-default">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">

          <li>
            <a type="submit" href="#index/myRecipes" ng-if="iftttLogged"
               data-target="#loginIFTTTModal">
              <span  aria-hidden="true"></span>Your recipes</a>
          </li>


         <!--
          <li><a href="#createRecipe">Create a recipe</a></li>
          -->
          <li>
            <a type="submit" href="" ng-if="!iftttLogged" data-toggle="modal"
               data-target="#loginIFTTTModal" ng-click="routeListener('createRecipe')">
              <span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> Create a recipe</a>
          </li>
          <li>

          <a type="submit" href="#createRecipe" ng-if="iftttLogged"
             data-target="#loginIFTTTModal">
            <span  aria-hidden="true"></span>Create a recipe</a>
          </li>
            <!--
          <li><a href="#chooseChannel">Channels</a></li>
            -->


        </ul>
        <form class="navbar-form navbar-right" role="search">
          <div class="form-group">
              <a href="" ng-click="logoutIFTTT()"><img id="IFTTTLogoON" ng-if="iftttLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Connected with IFTTT Polito" src="./images/logos/polito-logged-in.png" height="30" width="30"/></a>
              <img id="iftttLogoOFF" ng-if="!iftttLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Not logged in IFTTT Polito" src="./images/logos/polito-logged-out.png" height="30" width="30"/>
              <a href="" ng-click="logoutTwitter()"><img id="twitterLogoON" ng-if="twitterLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Connected with Twitter" src="./images/logos/twitter-logged-in.png" height="34" width="34"/></a>
            <img id="twitterLogoOFF" ng-if="!twitterLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Not logged in Twitter" src="./images/logos/twitter-logged-out.png" height="34" width="34"/>
            <a href="" ng-click="logoutGoogle()"><img id="googleLogoON" ng-if="googleLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Connected with Google (click to logout)" src="./images/logos/google-logged-in.png" height="30" width="30"/></a>
            <img id="googleLogoOFF" ng-if="!googleLogged" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="Not logged in Google" src="./images/logos/google-logged-out.png" height="30" width="30"/>
            <input ng-if="!iftttLogged" type="text" class="form-control" placeholder="username">
            <input ng-if="!iftttLogged" type="password" class="form-control" placeholder="password">
          </div>
          <button type="submit" class="btn btn-default" ng-if="!iftttLogged" data-toggle="modal" data-target="#loginIFTTTModal" ng-click="routeListener('index/myRecipes')"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> Login</button>
          <a href="#index/createAccount"><button type="submit" class="btn btn-default" ng-if="!iftttLogged"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Logon</button></a>
          <button type="submit" class="btn btn-default" ng-if="iftttLogged" ng-click="logoutIFTTT()">Logout <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span></button>
        </form>
      </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
  </nav>
  <!-- TOP NAVBAR END -->

  <!-- DEBUG AREA BEGIN -->
  {{"iftttLogged: "+ iftttLogged}}
  <br>
  {{"googleLogged: "+ googleLogged}}
  <br>
  {{"twitterLogged: "+ twitterLogged}}
  <!-- DEBUG AREA END -->

  <!-- NOTIFICATIONS WRAPPER BEGIN -->
  <div id="notificationsWrapper" style="margin: auto"></div>
  <!-- NOTIFICATIONS WRAPPER END -->

  <!-- INNER PAGES BEGIN -->
  <ng-view></ng-view>
  <!-- INNER PAGES END -->

  <!-- MODAL FORM IFTTT -- BEGIN -->
  <div class="modal fade" id="loginIFTTTModal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" style="padding-top: 10%">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
                  <h2 class="modal-title"><img src="images/logos/polito-logged-in.png" height="30" width="30"/> Login with IFTTT Polito</h2>
              </div>

              <div class="modal-body">
                  <!-- The form is placed inside the body of modal -->
                  <form class="form-horizontal">
                      <div class="form-group">
                          <label for="inputEmailIFTTT" class="col-sm-3 control-label">IFTTT Polito mail <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></label>
                          <div class="col-sm-9">
                              <input type="email" class="form-control" id="inputEmailIFTTT" placeholder="Email">
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="inputPasswordIFTTT" class="col-sm-3 control-label">Password <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></label>
                          <div class="col-sm-9">
                              <input type="password" class="form-control" id="inputPasswordIFTTT" placeholder="Password">
                          </div>
                      </div>
                      <div class="form-group">
                          <div class="col-sm-offset-3 col-sm-9">
                              <button id="ifttt-auth-btn" type="submit" class="btn btn-default" ng-click="requestIFTTTAuth()">Sign in</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
      </div>
  </div>
  <!-- MODAL FORM IFTTT -- END -->

  <!-- MODAL FORM GOOGLE -- BEGIN -->
  <div class="modal fade" id="loginGoogleModal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" style="padding-top: 10%">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h2 class="modal-title"><img src="./images/logos/google-logged-in.png" height="30" width="30"/> Login with Google</h2>
        </div>

        <div class="modal-body">
          <!-- The form is placed inside the body of modal -->
          <form class="form-horizontal">
            <div class="form-group">
              <label for="inputEmailGoogle" class="col-sm-3 control-label">Google mail <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></label>
              <div class="col-sm-9">
                <input type="email" class="form-control" id="inputEmailGoogle" placeholder="Email">
              </div>
            </div>
            <div class="form-group">
              <label for="inputPasswordGoogle" class="col-sm-3 control-label">Password <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></label>
              <div class="col-sm-9">
                <input type="password" class="form-control" id="inputPasswordGoogle" placeholder="Password">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-3 col-sm-9">
                <button id="google-auth-btn" type="submit" class="btn btn-default" ng-click="requestGoogleAuth()">Sign in</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- MODAL FORM GOOGLE -- END -->

  <!-- MODAL FORM TWITTER -- BEGIN -->
  <div class="modal fade" id="loginTwitterModal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" style="padding-top: 10%">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h2 class="modal-title"><img src="./images/logos/twitter-logged-in.png" height="30" width="30"/> Login with Twitter</h2>
        </div>

        <div class="modal-body">
          <!-- The form is placed inside the body of modal -->
          <form class="form-horizontal">
            <div class="form-group">
              <label for="inputEmailGoogle" class="col-sm-3 control-label">Twitter mail <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></label>
              <div class="col-sm-9">
                <input type="email" class="form-control" id="inputEmailTwitter" placeholder="Email">
              </div>
            </div>
            <div class="form-group">
              <label for="inputPasswordTwitter" class="col-sm-3 control-label">Password <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></label>
              <div class="col-sm-9">
                <input type="password" class="form-control" id="inputPasswordTwitter" placeholder="Password">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-3 col-sm-9">
                <button id="twitter-auth-btn" type="submit" class="btn btn-default" ng-click="requestTwitterAuth()">Sign in</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- MODAL FORM TWITTER -- END -->

  <!-- extra space bottom page -->
  <div style="padding-bottom: 6%">
    <br>
  </div>

  <!-- BOTTOM NAVBAR BEGIN -->
  <nav class="navbar navbar-inverse navbar-fixed-bottom navbar-default center">
    <div class="container">

      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar-collapse-2" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-inner" id="bs-navbar-collapse-2">
        <ul class="nav navbar-nav">
          <li><a href="#aboutSite"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> About the site</a></li>
          <li><a href="#ourTeam"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> The developers</a></li>
          <li><a href="http://www.polito.it" target="_blank"><span class="glyphicon glyphicon-education" aria-hidden="true"></span> PoliTo</a></li>
          <li><a href="https://creativecommons.org" target="_blank">Copyright <span class="glyphicon glyphicon-copyright-mark" aria-hidden="true"></span> IFTTT by PoliTo 2016</a></li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </div><!-- /.container-->
  </nav>
  <!-- BOTTOM NAVBAR END -->

  </body>
</html>

