<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
                <style>
                    /* STILE GENERALE */
                    body { font-family: 'Georgia', serif; font-size: 16px; margin: 0; padding: 0; background-color: #f8f8f8; }
                    
                    /* INTESTAZIONE */
                    header { 
                        background: #2c3e50; 
                        color: white; 
                        padding: 20px; 
                        text-align: center; 
                        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                    }
                    header h1 { margin: 0; font-size: 24px; }
                    .metadata { font-size: 0.9em; margin-top: 10px; color: #ecf0f1; }

                    /* LAYOUT A DUE COLONNE (SPLIT VIEW) */
                    .flex-container {
                        display: flex;
                        height: 90vh; /* Occupa quasi tutta l'altezza dello schermo */
                        overflow: hidden; /* Nasconde lo scroll della pagina intera */
                    }

                    /* COLONNA SINISTRA: IMMAGINE */
                    .facsimile-col {
                        flex: 1; /* Prende il 50% dello spazio */
                        overflow-y: auto; /* Permette lo scroll verticale */
                        background: #333; /* Sfondo scuro per far risaltare l'immagine */
                        padding: 10px;
                        text-align: center;
                        border-right: 5px solid #ccc;
                    }
                    .facsimile-col img {
                        max-width: 98%; /* L'immagine si adatta alla colonna */
                        height: auto;
                        box-shadow: 0 0 10px rgba(0,0,0,0.5);
                        margin-bottom: 20px;
                    }
                    .facsimile-col h2 { color: white; border-bottom: 1px solid white; padding-bottom: 5px; }

                    /* COLONNA DESTRA: TESTO */
                    .text-col {
                        flex: 1; /* Prende il 50% dello spazio */
                        overflow-y: auto; /* Permette lo scroll verticale */
                        padding: 40px;
                        background: white;
                    }

                    /* COLORI SEMANTICI */
                    .persName { color: #cc0000; font-weight: bold; }
                    .placeName, .geogName { color: #0000cc; font-weight: bold; }
                    .term { background-color: #ffff00; color: #000; padding: 0 2px; }
                    .foreign { color: #009900; font-style: italic; }
                    .orgName { color: #990099; font-weight: bold; }
                    .date { color: #ff6600; font-weight: bold; }
                    .title { text-decoration: underline; color: #000; }
                    .quote { color: #555; font-style: italic; }
                    
                    /* NOTE */
                    .note { font-size: 0.8em; vertical-align: super; color: #555; border-bottom: 1px dotted #999; cursor: help; }

                    /* ELEMENTI STRUTTURALI */
                    .page-break { 
                        display: block; 
                        text-align: center; 
                        color: #999; 
                        font-size: 0.8em; 
                        margin: 20px 0; 
                        border-top: 1px dashed #ccc; 
                        padding-top: 5px;
                    }
                    h2 { color: #2c3e50; border-bottom: 2px solid #eee; padding-bottom: 10px; }
                </style>
            </head>
            <body>
                <header>
                    <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                    <div class="metadata">
                        <span>Progetto: <xsl:value-of select="//tei:titleStmt/tei:respStmt/tei:name"/></span> | 
                        <span>Fonte: <xsl:value-of select="//tei:sourceDesc/tei:bibl/tei:title"/>, <xsl:value-of select="//tei:sourceDesc/tei:bibl/tei:date"/></span>
                    </div>
                </header>

                <div class="flex-container">
                    
                    <div class="facsimile-col">
                        <h2>Facsimile Originale</h2>
                        <xsl:apply-templates select="//tei:facsimile"/>
                    </div>

                    <div class="text-col">
                        <xsl:apply-templates select="//tei:text/tei:body"/>
                    </div>

                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:div"><div class="section"><xsl:apply-templates/></div></xsl:template>
    <xsl:template match="tei:head"><h2 style="text-align:center; margin-top:0;"><xsl:apply-templates/></h2></xsl:template>
    <xsl:template match="tei:p"><p><xsl:apply-templates/></p></xsl:template>
    <xsl:template match="tei:lb"><br/></xsl:template>
    
    <xsl:template match="tei:pb">
        <span class="page-break">
            --- Inizio Pagina <xsl:value-of select="@n"/> ---
        </span>
    </xsl:template>

    <xsl:template match="tei:opener"><div style="font-style:italic; margin-bottom:15px;"><xsl:apply-templates/></div></xsl:template>
    <xsl:template match="tei:closer"><div style="text-align:right; margin-top:30px; font-weight:bold;"><xsl:apply-templates/></div></xsl:template>
    <xsl:template match="tei:salute"><p><xsl:apply-templates/></p></xsl:template>
    <xsl:template match="tei:signed"><span><xsl:apply-templates/></span></xsl:template>

    <xsl:template match="tei:persName"><span class="persName"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:placeName"><span class="placeName"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:geogName"><span class="geogName"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:orgName"><span class="orgName"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:term"><span class="term"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:foreign"><span class="foreign"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:date"><span class="date"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:title"><span class="title"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:quote"><span class="quote"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="tei:hi[@rend='italic']"><i><xsl:apply-templates/></i></xsl:template>

    <xsl:template match="tei:note">
        <span class="note" title="Nota nel testo">[Nota <xsl:value-of select="@n"/>: <xsl:apply-templates/>]</span>
    </xsl:template>

    <xsl:template match="tei:surface">
        <xsl:for-each select="tei:graphic">
            <img src="{@url}" alt="Pagina originale" />
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>