<!--*
 *
 * (c) Copyright Ascensio System SIA 2019
 *
 * The MIT License (MIT)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
*-->

<%@page import="com.example.onlyofficedemo.entities.FileModel "%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ONLYOFFICE</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/editor.css" />

        <% FileModel Model = (FileModel) request.getAttribute("file"); %>

        <script type="text/javascript" src="${docserviceApiUrl}"></script>

        <script type="text/javascript" language="javascript">

        var docEditor;

        var innerAlert = function (message) {
            if (console && console.log)
                console.log(message);
        };

        var onAppReady = function () {
            innerAlert("Document editor ready");
        };

        var onDocumentStateChange = function (event) {
            var title = document.title.replace(/\*$/g, "");
            document.title = title + (event.data ? "*" : "");
        };

        var onRequestEditRights = function () {
            location.href = location.href.replace(RegExp("mode=view\&?", "i"), "");
        };

        var onError = function (event) {
            if (event)
                innerAlert(event.data);
        };

        var onOutdatedVersion = function (event) {
            location.reload(true);
        };

        var сonnectEditor = function () {
            var config = JSON.parse('<%= FileModel.Serialize(Model) %>');
            //alert(config.document.url)
            config.width = "100%";;
            config.height = "100%";
            config.events = {
                    "onAppReady": onAppReady,
                    "onDocumentStateChange": onDocumentStateChange,
                    'onRequestEditRights': onRequestEditRights,
                    "onError": onError,
                    "onOutdatedVersion": onOutdatedVersion,
                };


            docEditor = new DocsAPI.DocEditor("iframeEditor", config);
        };

        if (window.addEventListener) {
            window.addEventListener("load", сonnectEditor);
        } else if (window.attachEvent) {
            window.attachEvent("load", сonnectEditor);
        }



        var test =function () {
            builder.CreateFile("docx");
            var oDocument = Api.GetDocument();
            var oParagraph, oRun;
            oParagraph = oDocument.GetElement(0);
            oParagraph = Api.CreateParagraph();
            oParagraph.AddText("Dear John Smith.");
            oDocument.Push(oParagraph);
            oParagraph = Api.CreateParagraph();
            oParagraph.AddText("ONLYOFFICE is glad to announce that starting today, you are appointed Commercial director to the company of your dream.");
            oDocument.Push(oParagraph);
            oParagraph = Api.CreateParagraph();
            oRun = Api.CreateRun();
            oRun.SetBold(true);
            oRun.AddText("Please note: ");
            oParagraph.AddElement(oRun);
            oRun = Api.CreateRun();
            oRun.AddText("this text is used to demonstrate the possibilities of ");
            oParagraph.AddElement(oRun);
            oRun = Api.CreateRun();
            oRun.SetBold(true);
            oRun.AddText("ONLYOFFICE Document Builder");
            oParagraph.AddElement(oRun);
            oRun = Api.CreateRun();
            oRun.AddText(" and cannot be used as real appointment to the position in any real company.");
            oParagraph.AddElement(oRun);
            oDocument.Push(oParagraph);
            oParagraph = Api.CreateParagraph();
            oParagraph.AddText("Best regards,");
            oParagraph.AddLineBreak();
            oParagraph.AddText("ONLYOFFICE Document Builder Team");
            oDocument.Push(oParagraph);
            builder.SaveFile("docx", "SampleText.docx");
            builder.CloseFile();
        }

    </script>

    </head>
    <body>
        <div class="form">
            <div id="iframeEditor"></div>
        </div>
    </body>
</html>
