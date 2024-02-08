const express = require('express');
const nodemailer = require('nodemailer');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const userEmail = 'yourmailadress@gmail.com';
const userPassword = 'app password';

app.post('/send-mail', (req, res) => {
  const recipientEmail = req.body.recipientEmail; // Değişiklik

  if (!recipientEmail) {
    return res.status(400).send('Bad Request: E-posta adresi eksik');
  }

  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: userEmail,
      pass: userPassword,
    },
  });

  const mailOptions = {
    from: userEmail,
    to: recipientEmail,
    subject: 'Mail',
    text: 'Please subscribe to my YouTube channel',
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error(error); // Log the error details
      res.status(500).send(`Internal Server Error: ${error.message}`);
    } else {
      console.log('Email sent: ' + info.response);
      res.status(200).send('Email sent');
    }
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});