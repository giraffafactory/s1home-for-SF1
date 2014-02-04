
/* all ---------------------- */
* {
    margin: 0;
    padding: 0;
}

html, body {
    width: 100%;
    height: 100%;
    font-size: 15px;
    font-family: "ÉqÉâÉMÉmäpÉS Pro W3", "ÉÅÉCÉäÉI","ÇlÇr ÉSÉVÉbÉN", Osaka, "ÉqÉâÉMÉmäpÉS Pro W3", sans-serif;
    background-color: #F3F5F6;
}

#wrapper {
    height: 100%;
    background-color: #F3F5F6;
}

a {
    color: #0c86b8;
    text-decoration: none;
    display: block;
    font-weight: bold;
}


/* header ---------------------- */
#header {
    position: fixed;
    top: 0px;
    width: 100%;
    height: 38px;
    z-index: 999;
    box-sizing : border-box;

    padding-left: 20px;
    padding-right: 20px;
    padding-top: 4px;
//    vertical-align: middle;
    background-color: #3198d8;
    color: #FFFFFF;
    font-size: 15px;
}

.header_table {
    width: 100%;
}

.header_title {
    width: 40%;
    text-align: left;
    color: #FFFFFF;
    font-weight: bold;
}

.header_link {
    width: 60%;
    text-align: right;
    color: #FFFFFF;
}
.header_link a {
    color: #FFFFFF;
    display: inline;
}

.header_link a:link {
    color: #FFFFFF;
    text-decoration: none;
}
.header_link a:visited {
    color: #FFFFFF;
    text-decoration: none;
}
.header_link a:hover {
    color: #FFFFFF;
    text-decoration: none;
}
.header_link a:active {
    color: #FFFFFF;
    text-decoration: none;
}


/* main ---------------------- */
#main {
    height: 100%;
//    box-sizing : border-box;
    background-color: #F3F5F6;

    position: relative;
//    top: 38px;
    top: 0px;
    width: 100%;
}


/* menu ---------------------- */
#menu {
    position: fixed;
    top: 0px;
//    top: 38px;
//    z-index: 998;

    float: left;
//    overflow: scroll;
    width: 312px;
    height: 100%;
    background-color: #3C4148;
    font-size: 1em;
    color: #c2cad6;
    box-shadow: -4px 0px 10px 1px rgba(0,0,0,0.1) inset;
}

.menu_title {
    padding-top: 6px;
    padding-bottom: 6px;
    padding-left: 18px;
    padding-right: 18px;
//    background-color: #52585F;
    font-size: 12px;
    color: #c2cad6;
//    box-shadow: -4px 0px 10px 1px rgba(0,0,0,0.1) inset;
    background-image: -ms-linear-gradient(top left, #52585F 80%, #454A4F 100%);
    background-image: -moz-linear-gradient(top left, #52585F 80%, #454A4F 100%);
    background-image: -o-linear-gradient(top left, #52585F 80%, #454A4F 100%);
    background-image: -webkit-gradient(linear, left top, right bottom, color-stop(0.8, #52585F), color-stop(1, #454A4F));
    background-image: -webkit-linear-gradient(top left, #52585F 80%, #454A4F 100%);
    background-image: linear-gradient(to bottom right, #52585F 80%, #454A4F 100%);
    border-top-width: 1px;
    border-top-style: solid;
    border-top-color: #25272a;
}

#menu ul {
    border: 0px;
    box-shadow: 0px 0px;
}

#menu li {
    padding-top: 10px;
    padding-right: 20px;
    padding-bottom: 10px;
    padding-left: 20px;
//    background-color: #3C4148;
    font-size: 15px;
    line-height: 1.4em;
    color: #c2cad6;
    border-top-width: 1px;
    border-top-style: solid;
    border-top-color: #4A5059;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-bottom-color: #24272B;
//    box-shadow: -4px 0px 10px 1px rgba(0,0,0,0.1) inset;
    background-image: -ms-linear-gradient(top left, #3C4148 80%, #2F3338 100%);
    background-image: -moz-linear-gradient(top left, #3C4148 80%, #2F3338 100%);
    background-image: -o-linear-gradient(top left, #3C4148 80%, #2F3338 100%);
    background-image: -webkit-gradient(linear, left top, right bottom, color-stop(0.8, #3C4148), color-stop(1, #2F3338));
    background-image: -webkit-linear-gradient(top left, #3C4148 80%, #2F3338 100%);
    background-image: linear-gradient(top bottom right, #3C4148 80%, #2F3338 100%);
}

.menu_message {
    padding-top: 10px;
    padding-right: 20px;
    padding-bottom: 10px;
    padding-left: 20px;
    font-size: 12px;
    line-height: 1.4em;
    color: #c2cad6;
}

#menu a{
    color: #c2cad6;
    text-decoration: none;
}


/* contents ---------------------- */
#contents {
    float: left;
//    overflow: scroll;
    height: 100%;
//    box-sizing : border-box;
    background-color: #F3F5F6;
}

.contents_header {
    margin: 10px 0px 0px 0px;
    padding: 0;
    border: 0px solid #FF0000;
    border-collapse: collapse;
    width: 668px;
    
}

.contents_title {
    padding-top: 6px;
    padding-bottom: 6px;
    padding-left: 18px;
    padding-right: 18px;
    font-size: 24px;
    font-weight: bold;
    color: #000000;
}

.contents_title_right {
    padding-top: 6px;
    padding-bottom: 6px;
    padding-right: 18px;
    text-align: right;
}

.contents_button {
    margin-left: 20px;
    padding: 10px 0;
    background: -moz-linear-gradient(top,#FFF 0%,#EEE);
    background: -webkit-gradient(linear, left top, left bottom, from(#FFF), to(#EEE));
    border: 1px solid #CDCDCD;
    color: #6D6D6D;
    width: 100px;
    font-size: 12px;
    font-weight: bold;
}

.contents_select {
    width: 170px;
    height: 40px;
    padding: 10px 20px;
    text-align: center;
    text-align: -webkit-center;
    font-size: 12px;
    font-weight: bold;
/*
    background: -moz-linear-gradient(top,#FFF 0%,#EEE);
    background: -webkit-gradient(linear, left top, left bottom, from(#FFF), to(#EEE));
    border: 1px solid #CDCDCD;
    color:#6D6D6D;
*/
}

.contents_input {
    width: 100px;
    padding: 12px;
    font-size: 13px;
    text-align: center;
    font-weight: bold;
    background: -moz-linear-gradient(top,#FFF 0%,#EEE);
    background: -webkit-gradient(linear, left top, left bottom, from(#FFF), to(#EEE));
    border: 1px solid #CDCDCD;
    color: #6D6D6D;
}

.tbl_event {
    box-sizing : border-box;
    width: 668px;
    border-collapse: collapse;
//    border: 0px #dadcdd solid;
    border: 0px solid #dadcdd;
    border-top: 1px solid #dadcdd;
    table-layout: fixed;
    background-color: #FFFFFF;
}

.tbl_event th {
    border-bottom: 1px solid #dadcdd;
//    border-left: 1px solid #dadcdd;

    font-size: 12px;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-left: 10px;
    padding-right: 10px;
    background-color: #f2f2f2;
    color: #5D5D5D;

    background-image: -ms-linear-gradient(top, #ECEEF0 0%, #DDDFE1 50%);
    background-image: -moz-linear-gradient(top, #ECEEF0 0%, #DDDFE1 50%);
    background-image: -o-linear-gradient(top, #ECEEF0 0%, #DDDFE1 50%);
    background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #ECEEF0), color-stop(0.5, #DDDFE1));
    background-image: -webkit-linear-gradient(top, #ECEEF0 0%, #DDDFE1 50%);
    background-image: linear-gradient(to bottom, #ECEEF0 0%, #DDDFE1 50%);
    text-align: left;
}
.tbl_event td {
    border-bottom: 1px solid #dadcdd;
//    border-left: 1px solid #dadcdd;

    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 10px;
    padding-right: 10px;
}

.tbl_event a {
    display: inline;
}

.tbl_task {
    box-sizing : border-box;
    width: 668px;
    border-collapse: collapse;
    border: 0px solid #dadcdd;
    border-top: 1px solid #dadcdd;
    table-layout: fixed;
    background-color: #FFFFFF;
}

.tbl_task th {
    border-bottom: 1px solid #dadcdd;
    border-left: 1px solid #dadcdd;

    font-size: 12px;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-left: 10px;
    padding-right: 10px;
    background-color: #f2f2f2;

    background-image: -ms-linear-gradient(top, #FFFFFF 0%, #BFBFBF 400%);
    background-image: -moz-linear-gradient(top, #FFFFFF 0%, #BFBFBF 400%);
    background-image: -o-linear-gradient(top, #FFFFFF 0%, #BFBFBF 400%);
    background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #FFFFFF), color-stop(0.4, #BFBFBF));
    background-image: -webkit-linear-gradient(top, #FFFFFF 0%, #BFBFBF 400%);
    background-image: linear-gradient(to bottom, #FFFFFF 0%, #BFBFBF 400%);
    text-align: left;
}
.tbl_task td {
//    border: 1px #dadcdd solid;
    border-bottom: 1px solid #dadcdd;
//    border-left: 1px solid #dadcdd;

    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 10px;
    padding-right: 10px;
}

.contents_message {
    padding-top: 6px;
    padding-bottom: 6px;
    padding-left: 18px;
    padding-right: 18px;
    font-size: 14px;
    color: #000000;

}

#ui-datepicker-div { z-index: 1000; }
.ui-datepicker { z-index: 1000 !important; }

/* footer ---------------------- */
#footer {
    clear: both;
    width: 100%;

    position: absolute;
    bottom: 0px;
}
