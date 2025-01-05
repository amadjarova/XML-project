<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    <xsl:key name="languageById" match="programmingLanguages/programmingLanguage" use="@id" />

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
                        max-width: 200px;
                        max-height: 200px;
                        object-fit: cover;
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
                    .language-details {
                        display: none;
                        margin-top: 10px;
                        background-color: #f9f9f9;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                    }
                    .language-details p {
                        margin: 5px 0;
                    }
                </style>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
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

                        function toggleLanguageDetails(event) {
                            const details = event.target.nextElementSibling;
                            if (details.style.display === "none" || details.style.display === "") {
                                details.style.display = "block";
                                event.target.textContent = "Покажи по-малко информация";
                            } else {
                                details.style.display = "none";
                                event.target.textContent = "Покажи допълнителна информация";
                            }
                        }

                        document.getElementById("sort-name").addEventListener("click", sortByName);
                        document.getElementById("sort-industry").addEventListener("click", sortByIndustry);
                        const showMoreButtons = document.querySelectorAll(".show-more");
                        showMoreButtons.forEach(button => button.addEventListener("click", toggleLanguageDetails));
                    });
                </script>
            </head>
            <body>
                <h1>Списък на ИТ компании в България</h1>
                <div class="sort-options">
                    <button id="sort-name">Сортирай по име</button>
                    <button id="sort-industry">Сортирай по индустрия</button>
                </div>

                <div id="company-list">
                    <xsl:for-each select="catalogue/companies/company">
                        <div class="company">
                            <h2><xsl:value-of select="name" /></h2>

                            <div class="company-details">
                                <div class="industry"><strong>Индустрия:</strong> <xsl:value-of select="industry" /></div>
                                <div><strong>Година на основаване:</strong> <xsl:value-of select="establishmentYearOfFirstOfficeInTheCity" /></div>
                                <div><strong>Глобална година на основаване:</strong> <xsl:value-of select="establishmentYearGlobal" /></div>
                                <div><strong>Брой служители в града:</strong> <xsl:value-of select="numberOfEmployeesInTheCity" /></div>
                                <div><strong>Брой служители глобално:</strong> <xsl:value-of select="numberOfEmployeesGlobal" /></div>
                                <div><strong>Адрес:</strong> <xsl:value-of select="address" /></div>
                            </div>

                            <h3>Програмни езици:</h3>
                            <ul>
                                <xsl:for-each select="programmingLanguages/programmingLanguage">
                                    <li>
                                        <xsl:value-of select="key('languageById', @ref)/name" />
                                        <button class="show-more">Покажи допълнителна информация</button>
                                        <div class="language-details">
                                            <p><strong>Използва се основно за:</strong> <xsl:value-of select="key('languageById', @ref)/mainUsage" /></p>
                                            <p><strong>Година на създаване:</strong> <xsl:value-of select="key('languageById', @ref)/yearOfCreation" /></p>
                                        </div>
                                    </li>
                                </xsl:for-each>
                            </ul>

                            <h3>Продукти:</h3>
                            <ul>
                                <xsl:for-each select="products/product">
                                    <li><xsl:value-of select="." /></li>
                                </xsl:for-each>
                            </ul>

                            <h3>Изображения:</h3>
                            <div class="images">
                                <xsl:for-each select="images/image">
                                    <xsl:choose>
                                        <xsl:when test="@src">
                                            <img>
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="unparsed-entity-uri(@src)" />
                                                </xsl:attribute>
                                            </img>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <p>Изображението не е налично.</p>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </div>

                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
