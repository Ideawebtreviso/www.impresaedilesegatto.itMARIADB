<%@ Control Language="C#" ClassName="_gerarchia_computo_tabella_suddivisioni" %>

    <div id="popupModificaSuddivisione" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Modifica suddivisione</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">

                <table>
                    <tr>
                        <td>Modifica nome</td>
                        <td>
                            <span class="iwebCAMPO_id iwebNascosto"></span>
                            <input type="text" class="iwebCAMPO_descrizione" />
                        </td>
                    </tr>
                </table>

            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="
                    aggiornaNomeSuddivisione();
                                                    // chiudi e nascondi il popup
                                                    var popupAssociato = document.getElementById('popupModificaSuddivisione');
                                                    popupAssociato.className = 'popup popupType2 chiudiPopup';
                                                    setTimeout(function () { popupAssociato.style.display = 'none' }, 480);
                                            ">Aggiorna</div>
            </div>
            <span class="iwebSQLUPDATE">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                    "UPDATE suddivisione SET descrizione = @descrizione WHERE id = @idsuddivisione") %>
                </span>
                <span class="iwebPARAMETRO">@descrizione = popupModificaSuddivisione_findvalue_descrizione</span>
                <span class="iwebPARAMETRO">@idsuddivisione = popupModificaSuddivisione_findvalue_id</span>
            </span>
        </div>
    </div>
