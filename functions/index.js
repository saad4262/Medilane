const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const cors = require("cors")({origin: true}); // ✅ fixed spacing

const GMAIL_EMAIL = "saad.swl786@gmail.com";
const GMAIL_PASSWORD = "snfc kbxt fqvj sqas";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: GMAIL_EMAIL,
    pass: GMAIL_PASSWORD,
  },
});

exports.sendInvoiceEmail = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const {email, base64Pdf, orderId} = req.body; // ✅ fixed spacing

    const mailOptions = {
      from: GMAIL_EMAIL,
      to: email,
      subject: `Invoice for Order #${orderId}`,
      text: "Please find your invoice attached.",
      attachments: [
        {
          filename: `invoice_${orderId}.pdf`,
          content: base64Pdf,
          encoding: "base64",
        },
      ],
    };

    try {
      await transporter.sendMail(mailOptions);
      return res.status(200).send("Invoice sent");
    } catch (error) {
      console.error("Error sending email:", error);
      return res.status(500).send("Failed to send invoice");
    }
  });
});
