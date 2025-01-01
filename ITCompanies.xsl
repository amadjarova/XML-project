<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Списък на ИТ компании в България</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                        background-color: #f4f4f4;
                    }
                    h1 {
                        color: #2a5d84;
                    }
                    .company {
                        background-color: #ffffff;
                        padding: 15px;
                        margin-bottom: 20px;
                        border-radius: 8px;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    }
                    .company h2 {
                        margin-top: 0;
                    }
                    .company img {
                        max-width: 100%;
                        height: auto;
                        margin-top: 10px;
                    }
                    .company-details {
                        margin-top: 15px;
                    }
                    .company-details div {
                        margin-bottom: 8px;
                    }
                    .sort-options {
                        margin-bottom: 20px;
                    }
                </style>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // Функция за сортиране по име
                        function sortByName() {
                            const companies = Array.from(document.querySelectorAll(".company"));
                            companies.sort((a, b) => {
                                const nameA = a.querySelector("h2").textContent.toUpperCase();
                                const nameB = b.querySelector("h2").textContent.toUpperCase();
                                return nameA.localeCompare(nameB);
                            });
                            const container = document.getElementById("company-list");
                            companies.forEach(company => container.appendChild(company));
                        }

                        // Функция за сортиране по индустрия
                        function sortByIndustry() {
                            const companies = Array.from(document.querySelectorAll(".company"));
                            companies.sort((a, b) => {
                                const industryA = a.querySelector(".industry").textContent.toUpperCase();
                                const industryB = b.querySelector(".industry").textContent.toUpperCase();
                                return industryA.localeCompare(industryB);
                            });
                            const container = document.getElementById("company-list");
                            companies.forEach(company => container.appendChild(company));
                        }

                        // Свързване на бутоните със събития
                        document.getElementById("sort-name").addEventListener("click", sortByName);
                        document.getElementById("sort-industry").addEventListener("click", sortByIndustry);
                    });
                </script>
            </head>
            <body>
                <h1>Списък на ИТ компании в България</h1>

                <!-- Опции за сортиране -->
                <div class="sort-options">
                    <button id="sort-name">Сортирай по име</button>
                    <button id="sort-industry">Сортирай по индустрия</button>
                </div>

                <!-- Контейнер за компаниите -->
                <div id="company-list">
                    <xsl:for-each select="catalogue/companies/company">
                        <div class="company">
                            <h2><xsl:value-of select="name" /></h2>

                            <div class="company-details">
                                <div class="industry"><strong>Индустрия:</strong> <xsl:value-of select="industry" /></div>
                                <div><strong>Година на основаване:</strong> <xsl:value-of select="establishmentYear" /></div>
                                <div><strong>Брой служители:</strong> <xsl:value-of select="numberOfEmployees" /></div>
                                <div><strong>Адрес:</strong> <xsl:value-of select="address" /></div>
                            </div>

                            <h3>Програмиране езици:</h3>
                            <ul>
                                <xsl:for-each select="programmingLanguages/programmingLanguage">
                                    <li><xsl:value-of select="." /></li>
                                </xsl:for-each>
                            </ul>

                            <h3>Продукти:</h3>
                            <ul>
                                <xsl:for-each select="products/product">
                                    <li><xsl:value-of select="." /></li>
                                </xsl:for-each>
                            </ul>

                            <h3>Изображения:</h3>
                            <xsl:for-each select="images/image">
                                <img src="{.}" alt="Company Image" />
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

