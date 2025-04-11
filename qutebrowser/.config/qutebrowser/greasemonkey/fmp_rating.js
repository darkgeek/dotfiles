// ==UserScript==
// @name         FMP Rating
// @namespace    http://tampermonkey.net/
// @version      0.5
// @description  Show Rating
// @match        https://footballmanagerproject.com/Team/Player?id=*
// @match        https://footballmanagerproject.com/Team/Player/?id=*
// @grant        none
// @license      MIT
// @downloadURL https://update.greasyfork.org/scripts/527946/FMP%20Rating.user.js
// @updateURL https://update.greasyfork.org/scripts/527946/FMP%20Rating.meta.js
// ==/UserScript==

const RatingRate={
    0:[0.3,0.2,1.0,0.5,1.0,0.4,0.4,0.5,0.3,0.2,0.3],//GK
    4:[0.7,0.8,1.0,1.0,0.5,0.6,1.0,0.2,1.0,0.2,0.3],//DC
    5:[0.8,0.8,0.9,0.9,0.6,0.5,0.7,0.7,0.7,0.3,0.4],//DL
    6:[0.8,0.8,0.9,0.9,0.6,0.5,0.7,0.7,0.7,0.3,0.4],//DR
    8:[1.0,0.5,0.8,0.8,0.7,0.8,1.0,0.2,0.7,0.3,0.5],//DMC
    9:[0.9,0.9,0.7,0.7,0.7,0.6,0.7,0.9,0.4,0.3,0.5],//DML
    10:[0.9,0.9,0.7,0.7,0.7,0.6,0.7,0.9,0.4,0.3,0.5],//DMR
    16:[1.0,0.5,0.5,0.5,1.0,1.0,1.0,0.3,0.5,0.5,0.5],//MC
    17:[0.9,1.0,0.4,0.4,0.8,0.8,0.7,1.0,0.3,0.5,0.5],//ML
    18:[0.9,1.0,0.4,0.4,0.8,0.8,0.7,1.0,0.3,0.5,0.5],//MR
    32:[1.0,0.5,0.3,0.3,1.0,1.0,0.8,0.3,0.5,0.8,0.8],//AMC
    33:[0.8,1.0,0.2,0.2,0.9,0.7,0.7,1.0,0.4,0.7,0.7],//AML
    34:[0.8,1.0,0.2,0.2,0.9,0.7,0.7,1.0,0.4,0.7,0.7],//AMR
    64:[0.7,0.7,0.2,0.2,0.7,0.7,0.7,0.4,1.0,1.0,1.0],//FC
};

const currentUrl = window.location.href;
const urlObj = new URL(currentUrl);
const id = urlObj.searchParams.get('id');

function getId(id){
    const idDIv = document.createElement('tr');
    idDIv.innerHTML = '<th>ID</th><td>'+id+'</td>';
    return idDIv
}

function getRating(rating) {
    const ratingDiv = document.createElement('tr');
    ratingDiv.innerHTML = '<th>Rating</th><td>'+rating/10+'</td>';
    let infoTable = document.getElementsByClassName("infotable");
    infoTable[0].appendChild(ratingDiv);
}

function getRatingTable(skills, pos) {
    const targerElement = document.querySelectorAll('.d-flex.flex-wrap.justify-content-around');
    let postions = [4,5,8,9,16,17,32,33,64];

    let table={};
    if (pos === 0) {
        return;
    }
    else {
        for (let i of postions) {
            table[i] = getPosRating(skills,i);
        }
    }
    let tableDiv = document.createElement('table');
    tableDiv.className = 'skilltable';
    tableDiv.style.marginLeft = 'auto';
    tableDiv.style.marginRight = 'auto';

    let header='<th>位置</th><th>DC</th><th>DLR</th><th>DMC</th><th>DMLR</th><th>MC</th><th>MLR</th><th>OMC</th><th>OMLR</th><th>FC</th>';
    let rats='<td>Rating</td>';
    for (let i of postions) {
        rats+='<td>'+table[i].toFixed(2)+'</td>';
    }
    tableDiv.innerHTML='<tbody><tr>'+header+'</tr><tr>'+rats+'</tr></tbody>';

    targerElement[0].after(tableDiv);
    targerElement[0].after(document.createElement('br'));

}

function getPubTalent(pubTalent,pos) {
    const talentsDiv = document.getElementsByClassName("talents");
    const tdDiv = talentsDiv[0].getElementsByTagName("td");
    if (pos === 0) {
        tdDiv[0].textContent+=pubTalent.agi+1;
        tdDiv[1].textContent+=pubTalent.set+1;
        tdDiv[2].textContent+=pubTalent.str+1;
    }
    else {
        tdDiv[0].textContent+=pubTalent.ada+1;
        tdDiv[1].textContent+=pubTalent.agi+1;
        tdDiv[2].textContent+=pubTalent.set+1;
        tdDiv[3].textContent+=pubTalent.str+1;
    }
}

function getPosRating(skills,pos){
    let skillValue = [];
    if(pos === 0) {
        skillValue = [skills.Sta,
                      skills.Pac,
                      skills.Han,
                      skills.One,
                      skills.Ref,
                      skills.Aer,
                      skills.Pos,
                      skills.Jum,
                      skills.Kic,
                      skills.Ele,
                      skills.Thr];
    }
    else {
        skillValue = [skills.Sta,
                      skills.Pac,
                      skills.Mar,
                      skills.Tak,
                      skills.Tec,
                      skills.Pas,
                      skills.Pos,
                      skills.Cro,
                      skills.Hea,
                      skills.Fin,
                      skills.Lon];
    }
    const rating = skillValue.reduce((total, currentSkill, index) => {
        return total + currentSkill * RatingRate[pos][index];
    }, 0);
    const sum = RatingRate[pos].reduce((accumulator, currentValue) => accumulator + currentValue, 0);
    return rating/sum*(1+xpBonus(skills.Rou));
}

function getPlayers(pid,callback1,callback2,callback3){
    $.getJSON({
      "url": ("/Team/Player?handler=PlayerData&playerId=" + pid),
      "datatype": "json",
      "contentType": "application/json",
      "type": "GET"
    },
      function (ajaxResults) {
        callback1(ajaxResults.player.marketInfo.rating);
        ajaxResults.player.pos=fp2pos(ajaxResults.player.fp);
        var skills=decode(ajaxResults.player.skills,ajaxResults.player.pos)
        callback2(skills,ajaxResults.player.pos);
        callback3(ajaxResults.player.pubTalents,ajaxResults.player.pos);
      }
    );
}

function decode(binsk, pos) {
    var skills = Uint8Array.from(atob(binsk), c => c.charCodeAt(0));
    var sk = {};
    if (pos === 0) {
        sk.Han = skills[0] / 10;
        sk.One = skills[1] / 10;
        sk.Ref = skills[2] / 10;
        sk.Aer = skills[3] / 10;
        sk.Ele = skills[4] / 10;
        sk.Jum = skills[5] / 10;
        sk.Kic = skills[6] / 10;
        sk.Thr = skills[7] / 10;
        sk.Pos = skills[8] / 10;
        sk.Sta = skills[9] / 10;
        sk.Pac = skills[10] / 10;
        sk.For = skills[11] / 10;
        sk.Rou = (skills[12] * 256 + skills[13]) / 100;
    }
    else {
        sk.Mar = skills[0] / 10;
        sk.Tak = skills[1] / 10;
        sk.Tec = skills[2] / 10;
        sk.Pas = skills[3] / 10;
        sk.Cro = skills[4] / 10;
        sk.Fin = skills[5] / 10;
        sk.Hea = skills[6] / 10;
        sk.Lon = skills[7] / 10;
        sk.Pos = skills[8] / 10;
        sk.Sta = skills[9] / 10;
        sk.Pac = skills[10] / 10;
        sk.For = skills[11] / 10;
        sk.Rou = (skills[12] * 256 + skills[13]) / 100;
    }

    return sk;
}

function fp2pos(fp) {
  switch (fp) {
    case "GK": return 0;
    case "DC": return 4;
    case "DL": return 5;
    case "DR": return 6;
    case "DMC": return 8;
    case "DML": return 9;
    case "DMR": return 10;
    case "MC": return 16;
    case "ML": return 17;
    case "MR": return 18;
    case "OMC": return 32;
    case "OML": return 33;
    case "OMR": return 34;
    case "FC": return 64;
  }

  return -1;
}

function pos2fp(pos) {
  switch (pos) {
    case 0: return "GK";
    case 4: return "DC";
    case 5: return "DL";
    case 6: return "DR";
    case 8: return "DMC";
    case 9: return "DML";
    case 10: return "DMR";
    case 16: return "MC";
    case 17: return "ML";
    case 18: return "MR";
    case 32: return "OMC";
    case 33: return "OML";
    case 34: return "OMR";
    case 64: return "FC";
  }

  return "";
}

function xpBonus(rou) {
    return 5*rou/(rou+10)/100;
}

let observer = new MutationObserver((mutationsList, observer) => {
    for (let mutation of mutationsList) {
        if (mutation.type === 'childList') {
            let infoTable = document.getElementsByClassName("infotable");
            if (infoTable[0].firstChild) {
                infoTable[0].insertBefore(getId(id),infoTable[0].firstChild);
                getPlayers(id,getRating,getRatingTable,getPubTalent);
                observer.disconnect(); // 停止观察
                break;
            }
        }
    }
});

observer.observe(document.body, { childList: true, subtree: true });
