<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
    .post td{
        width: 50%;
    }
    .post th{
        text-align: left;
    }
    .post table{
        width:80%;
        margin-top: 10px;
        margin-bottom: 20px;
    }
</style>

<div class="post">
    <div class="postheader"></div>
    <div class="postcontent">
        <div class="pt"><h2>Projekt: Blog</h2></div>
        <table>
            <tr>
                <th>Autorzy:</th><th>Wykorzystane technologie:</th>
            </tr>
            <tr>
                <td>
                    <ul>
                        <li>Jarosław Bela</li>
                        <li>Marcin Dembowski</li>
                        <li>Mirosław Dziadyk</li>
                        <li>Piotr Gołębiowski</li>
                    </ul>
                </td>
                <td>
                    <ul>
                        <li>CouchDB</li>
                        <li>jQuery</li>
                        <li>Java (Spring)</li>
                    </ul>
                </td>
            </tr>
        </table>
        <blockquote>
        <p>
            Projekt powstał na zaliczenie ćwiczeń z przedmiotu <cite>Metody
            utrwalania danych w językach Ruby i Java</cite>. Wykorzystuje
            najnowszą technologię utrwalania.
        </p>
        </blockquote>
    </div>
    <div class="postbottom">
    </div>
</div>


