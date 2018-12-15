<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Chiffre d'affaire</title>
    <!-- On charge JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <!-- On charge l'API Google -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages': ['table']});
        google.charts.setOnLoadCallback(doAjax);

        function drawTable(dataArray) {
            var data = new google.visualization.DataTable(dataArray);
            data.addColumn('string', 'Name');
            data.addColumn('number', 'Ventes');
            for (var i = 1; i < dataArray.length; i++) {
                data.addRows([[dataArray[i][0], dataArray[i][1]]]);
            }

            var table = new google.visualization.Table(document.getElementById('table_div'));

            table.draw(data, {showRowNumber: true, width: '100%', height: '100%'});
        }

        // Afficher les ventes par client
        function doAjax() {
            $.ajax({
                url: "salesCustomer",
                data: $("#guessForm").serialize(),
                dataType: "json",
                success: // La fonction qui traite les résultats
                        function (result) {
                            // On reformate le résultat comme un tableau
                            var chartData = [];
                            // On met le descriptif des données
                            chartData.push(["Client", "Ventes"]);
                            for (var client in result.records) {
                                chartData.push([client, result.records[client]]);
                            }
                            // On dessine le graphique
                            drawTable(chartData);
                        },
                error: showError
            });
        }

        google.charts.load('current', {
            'packages': ['geochart'],
            // Note: you will need to get a mapsApiKey for your project.
            // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
            'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
        });
        google.charts.setOnLoadCallback(doAjax2);

        function drawRegionsMap(dataArray) {
            var data = google.visualization.arrayToDataTable(dataArray);

            var options = {
                region: 'US',
                colorAxis: {colors: ['#00853f', 'black', '#e31b23']},
                resolution: 'provinces',
                backgroundColor: '#81d4fa',
                datalessRegionColor: '#f8bbd0',
                defaultColor: '#f5f5f5',
            };

            var chart = new google.visualization.GeoChart(document.getElementById('geochart-colors'));
            chart.draw(data, options);
        }

        // Afficher les ventes par client
        function doAjax2() {
            $.ajax({
                url: "salesState",
                data: $("#guessForm").serialize(),
                dataType: "json",
                success: // La fonction qui traite les résultats
                        function (result) {
                            // On reformate le résultat comme un tableau
                            var chartData = [];
                            // On met le descriptif des données
                            chartData.push(["Etats", "Ventes"]);
                            for (var client in result.records) {
                                chartData.push([client, result.records[client]]);
                            }
                            // On dessine le graphique
                            drawRegionsMap(chartData);
                        },
                error: showError
            });
        }

        google.charts.load('current', {packages: ['corechart', 'bar']});
        google.charts.setOnLoadCallback(doAjax3);

        function drawBasic(dataArray) {

            var data = new google.visualization.DataTable(dataArray);
            data.addColumn('string', 'Produits');
            data.addColumn('number', 'Ventes');

            for (var i = 1; i < dataArray.length; i++) {
                data.addRows([[dataArray[i][0], dataArray[i][1]]]);
            }

            var options = {
                title: "Chiffre d'affaires par produits",
                hAxis: {
                    title: 'Produits',
                    viewWindow: {
                        min: [7, 30, 0],
                        max: [17, 30, 0]
                    }
                },
                vAxis: {
                    title: 'Ventes en Euros'
                }
            };

            var chart = new google.visualization.ColumnChart(
                    document.getElementById('chart_div'));

            chart.draw(data, options);
        }

        // Afficher les ventes par client
        function doAjax3() {
            $.ajax({
                url: "salesProduct",
                data: $("#guessForm").serialize(),
                dataType: "json",
                success: // La fonction qui traite les résultats
                        function (result) {
                            // On reformate le résultat comme un tableau
                            var chartData = [];
                            // On met le descriptif des données
                            chartData.push(["Produits", "Ventes"]);
                            for (var client in result.records) {
                                chartData.push([client, result.records[client]]);
                            }
                            // On dessine le graphique
                            drawBasic(chartData);
                        },
                error: showError
            });
        }

        // Fonction qui traite les erreurs de la requête
        function showError(xhr, status, message) {
            alert("Erreur: " + status + " : " + message);
        }

        function allCharts() {
            doAjax();
            doAjax2();
            doAjax3();
        }

    </script>
    <style type="text/css">
        #guessForm {
            font-family: 'Roboto', sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        body {
            background: #DCDCDC;
        }

        th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #4CAF50;
            color: white; 
        }


    </style>
</head>
<body>
    <h1> Les statistiques </h1>
    <form id="guessForm" method="POST" accept-charset="UTF-8" >
        Date de début : 
        <input type="date" id='debut' value="2010-05-06" name="debut">
        Date de fin : 
        <input type="date" id='fin' value="2018-05-06" name="fin">
        <button type="button" onclick="allCharts()"> Vérifier </button>
    </form>


    <!-- Les graphiques apparaît ici -->
    <table border="2">
        <TR>

            <TH>Chiffres d'affaires des Clients</TH>
            <th>Chiffres d'affaires par Etat</th>
            <th>Chiffres d'affaires par catégorie de produits</th>
        </TR>
        <tr>
            <TD><div id="table_div" style="width: 550px; height: 300px;"></div></td>
            <td><div id="geochart-colors" style="width: 550px; height: 300px;"></div></td>
            <td><div id="chart_div" style="width: 550px; height: 300px;"></div></td>
        </tr>
    </table>

    <form method="POST">
        <input type="SUBMIT" name="action" value="Vos Produits">
        <input type="SUBMIT" name="action" value="Deconnexion">
    </form> 
</body>