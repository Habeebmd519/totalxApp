const express = require("express");
const axios = require("axios");
const cors = require("cors");

const app = express(); // ✅ THIS WAS MISSING
const PORT = 3000;

app.use(cors());
app.use(express.json());

// TEST ROUTE
app.get("/", (req, res) => {
    res.send("OTP Server Running");
});

// SEND OTP
app.post("/send-otp", async (req, res) => {
    const { mobile } = req.body;

    console.log("SEND OTP API HIT:", req.body);

    try {
        const response = await axios.get(
            "https://control.msg91.com/api/v5/otp",
            {
                params: {
                    authkey: "492407AzE1hGroTmq698453deP1",
                    template_id: "6983c5536768b5163830763d",
                    mobile: `91${mobile}`,
                    sender: "TXTLX",
                    otp_expiry: 5,
                    otp_length: 6,
                    route: "otp"
                },
                timeout: 10000 // ⬅️ IMPORTANT
            }
        );

        console.log("MSG91 FULL RESPONSE:", JSON.stringify(response.data, null, 2));

        return res.status(200).json({
            success: true,
            msg91: response.data
        });

    } catch (error) {
        console.error(
            "MSG91 ERROR:",
            error.response?.data || error.message
        );

        return res.status(500).json({
            success: false,
            error: error.response?.data || error.message
        });
    }
});

// VERIFY OTP
app.post("/verify-otp", async (req, res) => {
    console.log("VERIFY OTP API HIT:", req.body);

    const { mobile, otp } = req.body;

    try {
        const response = await axios.get(
            "https://control.msg91.com/api/v5/otp/verify",
            {
                params: {
                    authkey: "492407AzE1hGroTmq698453deP1",
                    mobile: `91${mobile}`,
                    otp: otp,
                },
            }
        );

        console.log("MSG91 VERIFY RESPONSE:", response.data);
        res.json({ success: true });
    } catch (error) {
        console.log("VERIFY OTP ERROR:", error.response?.data || error.message);
        res.status(500).json({ success: false });
    }
});

// START SERVER
app.listen(PORT, "0.0.0.0", () => {
    console.log(`OTP server running on http://localhost:${PORT}`);
});