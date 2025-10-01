<%@ Control Language="C#" ClassName="_gerarchia_computo_elimina_suddivisione" %>


    <div id="popupEliminaSuddivisione" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Elimina suddivisione</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">

                <table>
                    <tr>
                        <td>Elimina suddivisione:</td>
                        <td>
                            <span class="iwebCAMPO_id iwebNascosto"></span>
                            <span class="iwebCAMPO_descrizione"></span>
                        </td>
                    </tr>
                </table>

            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-danger" onclick="
                    confermaEliminazioneSuddivisione();
                    // chiudi e nascondi il popup
                    var popupAssociato = document.getElementById('popupEliminaSuddivisione');
                    popupAssociato.className = 'popup popupType2 chiudiPopup';
                    setTimeout(function () { popupAssociato.style.display = 'none' }, 480);
                ">Elimina</div>
            </div>
            <span class="iwebSQLDELETE">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM suddivisione WHERE id = @idsuddivisione") %></span>
                <span class="iwebPARAMETRO">@idsuddivisione = popupEliminaSuddivisione_findvalue_id</span>
            </span>
        </div>
    </div>
