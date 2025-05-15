<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Popup Modal Test</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: #1a1a1a;
            color: white;
            font-family: Arial, sans-serif;
        }

        .btn {
            background: green;
            padding: 10px 20px;
            font-weight: bold;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            margin: 40px;
        }

        /* MODAL STYLES */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 100vw;
            background-color: rgba(0, 0, 0, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .modal-box {
            background-color: #a9a9a9;
            padding: 30px 40px;
            border-radius: 40px;
            width: 500px;
            max-width: 90%;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.4);
        }

        .modal-title {
            text-align: center;
            font-size: 24px;
            color: #4b0000;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .modal-box label {
            display: block;
            color: white;
            font-weight: bold;
            margin-top: 10px;
        }

        .modal-box input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 10px;
            border: none;
            margin-bottom: 10px;
        }

        .modal-note {
            font-size: 12px;
            text-align: center;
            font-weight: bold;
            margin: 10px 0 20px;
            color: black;
        }

        .modal-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .btn-red {
            background-color: #9c0000;
        }
    </style>
</head>
<body>

<!-- Trigger Button -->
<button class="btn" id="openModalBtn">+ NEW STUDENT</button>

<!-- Modal -->
<div id="studentModal" class="modal-overlay">
    <div class="modal-box">
        <h2 class="modal-title">CREATE NEW STUDENT</h2>
        <form>
            <label>NAME :</label>
            <input type="text" required>
            <label>NEW ID :</label>
            <input type="text" required>
            <label>NATIONAL ID NUM :</label>
            <input type="text" required>
            <label>PHONE NUMBER :</label>
            <input type="text" required>
            <p class="modal-note">DEFAULT PASSWORD WILL BE SET AS THE NATIONAL ID CARD NUMBER</p>
            <div class="modal-buttons">
                <button type="submit" class="btn">SUBMIT</button>
                <button type="button" id="closeModalBtn" class="btn btn-red">CANCEL</button>
            </div>
        </form>
    </div>
</div>

<!-- JavaScript -->
<script>
    const openModalBtn = document.getElementById("openModalBtn");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const modal = document.getElementById("studentModal");

    openModalBtn.addEventListener("click", () => {
        modal.style.display = "flex";
    });

    closeModalBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
</script>

</body>
</html>
