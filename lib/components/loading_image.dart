class LoadingImage {
  String loadingImage =
      '''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Generator: SVG Circus (http://svgcircus.com) -->

<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   id="SVG-Circus-d651ea81-1fef-a64e-fba6-f2330f0766f0"
   version="1.1"
   viewBox="0 0 100 100"
   preserveAspectRatio="xMidYMid meet"
   inkscape:version="0.91 r13725"
   sodipodi:docname="loadinganimationanim.svg">
  <metadata
     id="metadata12">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs10" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1916"
     inkscape:window-height="1035"
     id="namedview8"
     showgrid="false"
     inkscape:zoom="2.36"
     inkscape:cx="50"
     inkscape:cy="50"
     inkscape:window-x="4"
     inkscape:window-y="1"
     inkscape:window-maximized="1"
     inkscape:current-layer="SVG-Circus-d651ea81-1fef-a64e-fba6-f2330f0766f0" />
  <circle
     id="actor_3"
     cx="50"
     cy="75"
     r="5"
     opacity="1"
     fill="rgba(74,96,212,1)"
     fill-opacity="1"
     stroke="rgba(166,3,17,1)"
     stroke-width="3"
     stroke-opacity="1"
     stroke-dasharray="" />
  <circle
     id="actor_2"
     cx="59"
     cy="75"
     r="5"
     opacity="1"
     fill="rgba(74,96,212,1)"
     fill-opacity="1"
     stroke="rgba(166,3,17,1)"
     stroke-width="3"
     stroke-opacity="1"
     stroke-dasharray="" />
  <circle
     id="actor_1"
     cx="28"
     cy="75"
     r="12.5"
     opacity="1"
     fill="rgba(74,96,212,1)"
     fill-opacity="1"
     stroke="rgba(166,3,17,1)"
     stroke-width="3"
     stroke-opacity="1"
     stroke-dasharray="" />
  <script
     type="text/ecmascript"
     id="script6"><![CDATA[(function(){var actors={};actors.actor_1={node:document.getElementById("SVG-Circus-d651ea81-1fef-a64e-fba6-f2330f0766f0").getElementById("actor_1"),type:"circle",cx:28,cy:75,dx:25,dy:18,opacity:1};actors.actor_2={node:document.getElementById("SVG-Circus-d651ea81-1fef-a64e-fba6-f2330f0766f0").getElementById("actor_2"),type:"circle",cx:59,cy:75,dx:10,dy:18,opacity:1};actors.actor_3={node:document.getElementById("SVG-Circus-d651ea81-1fef-a64e-fba6-f2330f0766f0").getElementById("actor_3"),type:"circle",cx:50,cy:75,dx:10,dy:18,opacity:1};var tricks={};tricks.trick_1=(function(_,t){t=(function(t){return(t/=.5)<1?-0.5*(Math.sqrt(1-t*t)-1):.5*(Math.sqrt(1-(t-=2)*t)+1)})(t)%1,t=t*4%1,t=0>t?1+t:t;var a=(_.node,-25*Math.cos(-90*Math.PI/180)),i=25*Math.sin(-90*Math.PI/180);a+=25*Math.cos((-90-360*t*1)*Math.PI/180),i-=25*Math.sin((-90-360*t*1)*Math.PI/180),_._tMatrix[4]+=a,_._tMatrix[5]+=i});tricks.trick_2=(function(t,i){i=(function(n){return.5>n?2*n*n:-1+(4-2*n)*n})(i)%1,i=0>i?1+i:i;var _=t.node;0.1>=i?_.setAttribute("opacity",i*(t.opacity/0.1)):i>=0.9?_.setAttribute("opacity",t.opacity-(i-0.9)*(t.opacity/(1-0.9))):_.setAttribute("opacity",t.opacity)});var scenarios={};scenarios.scenario_1={actors: ["actor_1","actor_2","actor_3"],tricks: [{trick: "trick_1",start:0,end:1},{trick: "trick_2",start:0,end:1}],startAfter:0,duration:6000,actorDelay:300,repeat:0,repeatDelay:1000};var _reqAnimFrame=window.requestAnimationFrame||window.mozRequestAnimationFrame||window.webkitRequestAnimationFrame||window.oRequestAnimationFrame,fnTick=function(t){var r,a,i,e,n,o,s,c,m,f,d,k,w;for(c in actors)actors[c]._tMatrix=[1,0,0,1,0,0];for(s in scenarios)for(o=scenarios[s],m=t-o.startAfter,r=0,a=o.actors.length;a>r;r++){if(i=actors[o.actors[r]],i&&i.node&&i._tMatrix)for(f=0,m>=0&&(d=o.duration+o.repeatDelay,o.repeat>0&&m>d*o.repeat&&(f=1),f+=m%d/o.duration),e=0,n=o.tricks.length;n>e;e++)k=o.tricks[e],w=(f-k.start)*(1/(k.end-k.start)),tricks[k.trick]&&tricks[k.trick](i,Math.max(0,Math.min(1,w)));m-=o.actorDelay}for(c in actors)i=actors[c],i&&i.node&&i._tMatrix&&i.node.setAttribute("transform","matrix("+i._tMatrix.join()+")");_reqAnimFrame(fnTick)};_reqAnimFrame(fnTick);})()]]></script>
  <g
     transform="scale(0.84982994,1.176706)"
     style="font-style:normal;font-weight:normal;font-size:20.63843536px;line-height:125%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;opacity:0.78964401;fill:#ffffff;fill-opacity:1;stroke:#b0b0b0;stroke-width:0.30000001;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
     id="text4140">
    <path
       d="m 20.740615,27.757023 -5.522393,0 0,-12.254071 -2.741043,0 0,14.541632 8.263436,0 0,-2.287561 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4145" />
    <path
       d="m 27.472292,15.261096 c -3.859629,0 -6.14719,2.781351 -6.14719,7.517711 0,4.746437 2.287561,7.507634 6.14719,7.507634 3.85963,0 6.147191,-2.761197 6.147191,-7.507634 0,-4.73636 -2.287561,-7.517711 -6.147191,-7.517711 z m 0,2.307715 c 2.086014,0 3.345684,1.864312 3.345684,5.209996 0,3.335606 -1.25967,5.199918 -3.345684,5.199918 -2.096091,0 -3.345683,-1.864312 -3.345683,-5.199918 0,-3.345684 1.25967,-5.209996 3.345683,-5.209996 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4147" />
    <path
       d="m 43.364292,30.044584 2.90228,0 -4.454193,-14.541632 -3.28522,0 -4.464271,14.541632 2.821661,0 0.967427,-3.486767 4.524735,0 0.987581,3.486767 z m -3.305374,-11.840899 0.08062,0 1.703074,6.247964 -3.456535,0 1.672842,-6.247964 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4149" />
    <path
       d="m 47.627013,15.502952 0,14.541632 4.917752,0 c 3.97048,0 6.217732,-2.579804 6.217732,-7.316164 0,-4.73636 -2.247252,-7.225468 -6.217732,-7.225468 l -4.917752,0 z m 2.741042,2.297639 1.844157,0 c 2.448799,0 3.748779,1.652687 3.748779,4.937907 0,3.355761 -1.259671,5.008448 -3.748779,5.008448 l -1.844157,0 0,-9.946355 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4151" />
    <path
       d="m 63.30739,30.044584 0,-14.541632 -2.741042,0 0,14.541632 2.741042,0 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4153" />
    <path
       d="m 68.073981,30.044584 0,-10.026974 0.07054,0 5.854947,10.026974 2.569727,0 0,-14.541632 -2.539495,0 0,10.00682 -0.08062,0 -5.834792,-10.00682 -2.589882,0 0,14.541632 2.549572,0 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4155" />
    <path
       d="m 90.284485,23.967936 0,-1.612378 -5.582858,0 0,2.055781 2.912357,0 0,0.282167 c -0.04031,2.015472 -1.179051,3.295297 -2.982899,3.295297 -2.17671,0 -3.426303,-1.914699 -3.426303,-5.300692 0,-3.315452 1.168974,-5.129377 3.325529,-5.129377 1.501527,0 2.519341,0.906962 2.882126,2.599959 l 2.751119,0 c -0.372862,-3.013131 -2.509263,-4.897597 -5.643322,-4.897597 -3.839475,0 -6.116958,2.700732 -6.116958,7.457247 0,4.827056 2.297638,7.568098 6.197577,7.568098 3.648005,0 5.683632,-2.307716 5.683632,-6.318505 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4157" />
    <path
       d="m 93.620095,30.165513 c 0.846498,0 1.511604,-0.665106 1.511604,-1.511605 0,-0.846498 -0.665106,-1.501526 -1.511604,-1.501526 -0.846498,0 -1.511604,0.655028 -1.511604,1.501526 0,0.846499 0.665106,1.511605 1.511604,1.511605 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4159" />
    <path
       d="m 98.820008,30.165513 c 0.846498,0 1.511602,-0.665106 1.511602,-1.511605 0,-0.846498 -0.665104,-1.501526 -1.511602,-1.501526 -0.846498,0 -1.511604,0.655028 -1.511604,1.501526 0,0.846499 0.665106,1.511605 1.511604,1.511605 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4161" />
    <path
       d="m 104.01993,30.165513 c 0.8465,0 1.5116,-0.665106 1.5116,-1.511605 0,-0.846498 -0.6651,-1.501526 -1.5116,-1.501526 -0.8465,0 -1.51161,0.655028 -1.51161,1.501526 0,0.846499 0.66511,1.511605 1.51161,1.511605 z"
       style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'.SF NS Display Condensed';-inkscape-font-specification:'.SF NS Display Condensed, Bold';stroke:#b0b0b0;stroke-width:0.30000001;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       id="path4163" />
  </g>
</svg>
''';
}
