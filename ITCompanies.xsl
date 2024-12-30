<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Catalogue of Companies</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    h1 {
                        text-align: center;
                        color: #333;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: left;
                    }
                    th {
                        background-color: #f4f4f4;
                        cursor: pointer;
                    }
                    th a {
                        text-decoration: none;
                        color: #000;
                    }
                </style>
            </head>
            <body>
                <h1>Catalogue of Companies</h1>
                <table id="companyTable">
                    <thead>
                        <tr>
                            <th><a href="javascript:void(0);" onclick="sortTable(0)">Company Name</a></th>
                            <th><a href="javascript:void(0);" onclick="sortTable(1)">Industry</a></th>
                            <th><a href="javascript:void(0);" onclick="sortTable(2)">Year Established</a></th>
                            <th><a href="javascript:void(0);" onclick="sortTable(3)">Number of Employees</a></th>
                            <th><a href="javascript:void(0);" onclick="sortTable(4)">Address</a></th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="/catalogue/companies/company">
                            <tr>
                                <td><xsl:value-of select="name" /></td>
                                <td><xsl:value-of select="industry" /></td>
                                <td><xsl:value-of select="establishmentYear" /></td>
                                <td><xsl:value-of select="numberOfEmployees" /></td>
                                <td><xsl:value-of select="address" /></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>

                <script>
                    function sortTable(n) {
                        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                        table = document.getElementById("companyTable");
                        switching = true;
                        dir = "asc"; // Set the sorting direction to ascending initially

                        while (switching) {
                            switching = false;
                            rows = table.rows;

                            for (i = 1; i < (rows.length - 1); i++) {
                                shouldSwitch = false;
                                x = rows[i].getElementsByTagName("TD")[n];
                                y = rows[i + 1].getElementsByTagName("TD")[n];

                                if (dir == "asc") {
                                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                        shouldSwitch = true;
                                        break;
                                    }
                                } else if (dir == "desc") {
                                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                        shouldSwitch = true;
                                        break;
                                    }
                                }
                            }

                            if (shouldSwitch) {
                                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                                switching = true;
                                switchcount++;
                            } else {
                                if (switchcount == 0 && dir == "asc") {
                                    dir = "desc";
                                    switching = true;
                                }
                            }
                        }
                    }
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
