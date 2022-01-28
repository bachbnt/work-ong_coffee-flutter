importScripts('https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js');
importScripts(
  'https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js'
);

firebase.initializeApp({
  apiKey: 'AIzaSyBCMuIfi4VNjTIWi87MK6XoWMEhT9ORMhI',
  authDomain: 'ongcoffee-805da.firebaseapp.com',
  projectId: 'ongcoffee-805da',
  storageBucket: 'ongcoffee-805da.appspot.com',
  messagingSenderId: '606246164324',
  appId: '1:606246164324:web:bdb43a9d7e07880cf0cc71',
  measurementId: 'G-Q8RS4607RC',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log('onBackgroundMessage', message);
});
