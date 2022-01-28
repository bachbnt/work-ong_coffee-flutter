importScripts('https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js');
importScripts(
  'https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js'
);

firebase.initializeApp({
  apiKey: 'AIzaSyCuZoFChr7Pji2IEy_X8J_ufBlGV1QsQPE',
  authDomain: 'ongcoffeedelivery.firebaseapp.com',
  projectId: 'ongcoffeedelivery',
  storageBucket: 'ongcoffeedelivery.appspot.com',
  messagingSenderId: '579723618334',
  appId: '1:579723618334:web:86abc07d3e33164849e60f',
  measurementId: 'G-QXECQ5SH7H',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log('onBackgroundMessage', message);
});
