<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='text'/>
  <xsl:template match="/"><![CDATA[<!DOCTYPE html>
<html>
  <head>
    <title>HTML Report</title>
    <style>
      body {
        font-size: 12pt;
        font-family: Georgia;
      }
      h1 { font-size:16pt; margin:14pt 0pt 0pt 0pt; padding:0pt 0pt 4pt 0pt; }
      details { font-size:12pt; margin:7pt; padding:7pt 14pt 7pt 14pt; }
      h2 { font-size:12pt; margin:12pt 0pt 0pt 0pt; padding:0pt 0pt 3pt 0pt; }
      .success      { background-color: #C5D88A; }
      .inconclusive { background-color: #EAEC2D; }
      .failure      { background-color: #D88A8A; }
      .failureMessage { background-color: #EDBBBB; color:black; margin:0px; padding:5pt 0pt 5pt 5pt;}
      hr { width: 100%; height: 1pt; margin:14pt 0px 0px 0px; color: grey; background: grey; }
      pre {
          font-family: Consolas,monospace;
          font-size: 12pt;
          white-space: pre-wrap;
          white-space: -moz-pre-wrap;
          white-space: -pre-wrap;
          white-space: -o-pre-wrap;
          word-wrap: break-word;
      }
      table { border-spacing: 0; }
      td, th { padding: 0pt 5pt 0pt 0pt; }
      th, td { text-align: right }
      #overview { overflow:hidden }
      #results  { float: left; }
      #summary  { float: right; clear:right; }
    </style>
  </head>
  <body>
    <h1>Pester Gherkin Run</h1>]]>
    <!-- Apply root element transformation -->
    <xsl:apply-templates select="//test-results" />
<![CDATA[
  </body>
</html>
]]>
  </xsl:template>

  <!-- Transformation for root element -->
  <xsl:template match="test-results">
  
    <xsl:text>&lt;div id="overview"&gt;</xsl:text>
    <xsl:text>&lt;div id="results"&gt;</xsl:text>
    <!--<xsl:text>&lt;h2&gt;Test results&lt;/h2&gt;</xsl:text>-->
    <xsl:text>&lt;table&gt;</xsl:text>

    <xsl:text>&lt;tr&gt;&lt;td&gt;&amp;nbsp;&lt;/td&gt;</xsl:text>
    <xsl:text>&lt;th&gt;Total&lt;/th&gt;</xsl:text>
    <xsl:text>&lt;th class="success"&gt;Passed&lt;/th&gt;</xsl:text>
    <xsl:text>&lt;th class="inconclusive"&gt;Skipped&lt;/th&gt;</xsl:text>
    <xsl:text>&lt;th class="failure"&gt;Failed&lt;/th&gt;</xsl:text>
    <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>

    <xsl:text>&lt;tr&gt;&lt;th&gt;Scenarios:&lt;/th&gt;&lt;td&gt;</xsl:text>
    <xsl:value-of select="count(node()/results/test-suite/results/test-suite)"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="success"&gt;</xsl:text>
    <xsl:value-of select="count(node()/results/test-suite/results/test-suite[count(node()//test-case[@result='Success']) &gt; 0 and count(node()//test-case[@result='Success']) = count(node()//test-case)])"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="inconclusive"&gt;</xsl:text>
    <xsl:value-of select="count(node()/results/test-suite/results/test-suite[count(node()//test-case[@result='Inconclusive']) &gt; 0 and count(node()//test-case[@result='Failure']) = 0])"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="failure"&gt;</xsl:text>
    <xsl:value-of select="count(node()/results/test-suite/results/test-suite[count(node()//test-case[@result='Failure']) &gt; 0])"/>
    <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>

    <xsl:text>&lt;tr&gt;&lt;th&gt;Steps:&lt;/th&gt;&lt;td&gt;</xsl:text>
    <xsl:value-of select="count(//test-case)"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="success"&gt;</xsl:text>
    <xsl:value-of select="count(//test-case[@result='Success'])"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="inconclusive"&gt;</xsl:text>
    <xsl:value-of select="count(//test-case[@result='Inconclusive'])"/>
    <xsl:text>&lt;/td&gt;</xsl:text>

    <xsl:text>&lt;td class="failure"&gt;</xsl:text>
    <xsl:value-of select="count(//test-case[@result='Failure'])"/>
    <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
    <xsl:text>&lt;/table&gt;&lt;/div&gt;</xsl:text>

    <xsl:text>&lt;div id="summary"&gt;</xsl:text>
    <!--<xsl:text>&lt;h2&gt;Summary&lt;/h2&gt;</xsl:text>-->

    <xsl:text>&lt;table&gt;</xsl:text>
    
    <xsl:text>&lt;tr&gt;&lt;th&gt;Operating system:&lt;/th&gt;&lt;td&gt;</xsl:text>
    <xsl:value-of select="substring-before(environment/@platform,'|')"/><xsl:text>&lt;/td&gt;&lt;/tr&gt;
    </xsl:text>

    <xsl:text>&lt;tr&gt;&lt;th&gt;Version:&lt;/th&gt;&lt;td&gt;</xsl:text>
    <xsl:value-of select="environment/@os-version"/><xsl:text>&lt;/td&gt;&lt;/tr&gt;
    </xsl:text>
    
    <xsl:text>&lt;tr&gt;&lt;th&gt;Execution time:&lt;/th&gt;&lt;td&gt;</xsl:text>
    <xsl:value-of select="test-suite/@time"/>
    <xsl:text> seconds&lt;/td&gt;&lt;/tr&gt;
    </xsl:text>

    <xsl:text>&lt;/table&gt;&lt;/div&gt;&lt;/div&gt;</xsl:text>

    <!-- Apply test-results transformation -->
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Transformation of top-level test-suites which are the feature files -->
  <xsl:template match="/test-results/test-suite/results/test-suite">
    <xsl:text>&lt;hr&gt;
    &lt;h2&gt;</xsl:text>

    <!-- Feature file name -->
    <xsl:value-of select="@name"/>
    <xsl:text>&lt;/h2&gt;
    </xsl:text>

    <!-- Iterate over second-level test-suites which are the scenarios -->
    <xsl:for-each select="results/test-suite">
      <!-- Use HTML element details to make scenarios expandable and collapsable -->
      <xsl:text><![CDATA[<details]]></xsl:text>
      <xsl:choose>
        <xsl:when test="count(node()//test-case[@result='Success']) &gt; 0 and count(node()//test-case[@result='Success']) = count(node()//test-case)">
          <xsl:text> class="success</xsl:text>
        </xsl:when>
        <xsl:when test="count(node()//test-case[@result='Failure']) &gt; 0">
          <!-- Only failures will be opened by default -->
          <xsl:text> open class="failure</xsl:text>
        </xsl:when>
        <xsl:otherwise>
        <xsl:text> class="inconclusive</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text><![CDATA[">
      <summary>]]></xsl:text>
      <xsl:text>&lt;strong&gt;</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>&lt;/strong&gt;</xsl:text>
      <xsl:text>&lt;/summary&gt;
      </xsl:text>

      <!-- Iterate over test-cases which are the scenario steps -->
      <xsl:for-each select="results//test-case">
        <xsl:text><![CDATA[<div class="]]></xsl:text><xsl:choose>
          <xsl:when test="@result = 'Success'">
            <xsl:text>success</xsl:text>
          </xsl:when>
          <xsl:when test="@result = 'Inconclusive'">
            <xsl:text>inconclusive</xsl:text>
          </xsl:when>
          <xsl:otherwise>
          <xsl:text>failure</xsl:text>
          </xsl:otherwise>
        </xsl:choose><xsl:text><![CDATA[">]]></xsl:text>
        <!-- The description of the test-case contains the complete step text -->
        <xsl:value-of select="@description"/>
        <xsl:text><![CDATA[</div>]]>
      </xsl:text>
        <!-- Failure message will be displayed too -->
        <xsl:if test="failure/message">
          <xsl:text><![CDATA[<pre class="failureMessage">]]></xsl:text><xsl:value-of select="failure/message"/><xsl:text><![CDATA[</pre>]]>
          </xsl:text>
        </xsl:if>
        <!-- TODO Consider to output */message instead of just failure/message to include messages for inconclusive tests for example -->
      </xsl:for-each>
      <xsl:text><![CDATA[</details>]]>
      </xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>