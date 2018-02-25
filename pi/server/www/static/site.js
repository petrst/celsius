var T0=Date.now();
var footer=document.getElementById('footer');

function timeBefore(){
    var genBefore=Math.round((Date.now()-T0)/1000);
    footer.innerHTML='Generated '+genBefore+' secs ago';
}
window.setInterval(timeBefore,1000);


if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('serviceWorker.js', {
    scope: '/celsius/'
  });
  console.log("Service worker registered");
}

