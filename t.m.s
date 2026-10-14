
<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="theme-color" content="#102b46">
  <title>مترویار | زمان حرکت قطار</title>

  <style>
    :root {
      --bg: #f2f6fa;
      --navy: #102b46;
      --blue: #246bfd;
      --green: #12a879;
      --text: #182b40;
      --muted: #718096;
      --border: #e0e8f0;
      --white: #ffffff;
    }

    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Tahoma, Arial, sans-serif;
      background: var(--bg);
      color: var(--text);
      line-height: 1.8;
    }

    button, select {
      font: inherit;
    }

    .header {
      background: var(--navy);
      color: white;
      padding: 24px 18px 54px;
      border-radius: 0 0 30px 30px;
    }

    .header-inner, main {
      width: min(100% - 32px, 760px);
      margin: auto;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .logo {
      display: grid;
      place-items: center;
      width: 48px;
      height: 48px;
      border-radius: 15px;
      background: #234c70;
      font-size: 27px;
    }

    h1 {
      margin: 0;
      font-size: 25px;
    }

    .subtitle {
      margin: 3px 0 0;
      color: #c5d5e5;
      font-size: 13px;
    }

    .clock {
      margin-top: 25px;
      padding: 15px 18px;
      border: 1px solid #34516b;
      border-radius: 18px;
      background: #173650;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
    }

    .clock-label {
      color: #c5d5e5;
      font-size: 13px;
    }

    #currentTime {
      font-size: 27px;
      font-weight: bold;
      direction: ltr;
      font-variant-numeric: tabular-nums;
    }

    main {
      margin-top: -28px;
      padding-bottom: 35px;
    }

    .card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: 22px;
      padding: 22px;
      margin-bottom: 17px;
      box-shadow: 0 8px 25px #193a5710;
    }

    .section-title {
      font-size: 17px;
      font-weight: bold;
      margin: 0 0 16px;
    }

    .field {
      margin-bottom: 16px;
    }

    .field:last-child {
      margin-bottom: 0;
    }

    label {
      display: block;
      font-size: 13px;
      font-weight: bold;
      margin-bottom: 7px;
    }

    select {
      width: 100%;
      min-height: 49px;
      border: 1px solid #d7e1ec;
      border-radius: 12px;
      padding: 10px 12px;
      color: var(--text);
      background: #fbfdff;
      outline: none;
    }

    select:focus {
      border-color: var(--blue);
      box-shadow: 0 0 0 3px #246bfd20;
    }

    .result {
      background: linear-gradient(145deg, #102b46, #19496b);
      color: white;
      border: none;
      overflow: hidden;
      position: relative;
    }

    .result::after {
      content: "🚇";
      position: absolute;
      left: 15px;
      top: 12px;
      font-size: 45px;
      opacity: .13;
    }

    .result-label {
      color: #c5d5e5;
      font-size: 13px;
    }

    #countdown {
      margin: 8px 0;
      font-size: clamp(34px, 9vw, 49px);
      font-weight: bold;
      line-height: 1.4;
      font-variant-numeric: tabular-nums;
      direction: ltr;
      text-align: right;
    }

    #status {
      font-size: 14px;
      color: #d7e8f7;
    }

    .departure-time {
      display: inline-block;
      margin-top: 14px;
      padding: 7px 13px;
      background: #ffffff18;
      border: 1px solid #ffffff25;
      border-radius: 10px;
      font-size: 14px;
    }

    .warning {
      display: none;
      margin-top: 14px;
      padding: 10px 12px;
      border-radius: 12px;
      background: #fff1d6;
      color: #855400;
      font-size: 13px;
    }

    .warning.show {
      display: block;
    }

    .schedule-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .schedule-list li {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      padding: 12px 0;
      border-bottom: 1px solid var(--border);
    }

    .schedule-list li:last-child {
      border-bottom: none;
    }

    .time {
      direction: ltr;
      font-weight: bold;
      font-variant-numeric: tabular-nums;
    }

    .remaining {
      color: var(--muted);
      font-size: 12px;
    }

    .empty {
      color: var(--muted);
      font-size: 14px;
      text-align: center;
      padding: 18px 5px;
    }

    .notice {
      padding: 14px;
      background: #fff8e8;
      border: 1px solid #f0dfb7;
      border-radius: 15px;
      color: #79591c;
      font-size: 12px;
      margin-bottom: 17px;
    }

    .notice a {
      color: #174fa8;
      overflow-wrap: anywhere;
    }

    .footer {
      color: var(--muted);
      text-align: center;
      font-size: 12px;
      padding: 10px;
    }

    @media (min-width: 600px) {
      .header {
        padding-top: 32px;
      }

      .fields {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
      }

      .field {
        margin-bottom: 0;
      }

      .card {
        padding: 26px;
      }
    }

    @media (prefers-reduced-motion: no-preference) {
      .warning.show {
        animation: appear .25s ease-out;
      }

      @keyframes appear {
        from { opacity: 0; transform: translateY(-4px); }
        to { opacity: 1; transform: translateY(0); }
      }
    }
  </style>
</head>

<body>
  <header class="header">
    <div class="header-inner">
      <div class="brand">
        <div class="logo" aria-hidden="true">🚇</div>
        <div>
          <h1>مترویار</h1>
          <p class="subtitle">همیشه یک قدم جلوتر از قطار</p>
        </div>
      </div>

      <div class="clock">
        <div>
          <div class="clock-label">ساعت فعلی دستگاه شما</div>
          <div id="currentDate" class="clock-label"></div>
        </div>
        <div id="currentTime" aria-live="off">--:--:--</div>
      </div>
    </div>
  </header>

  <main>
    <section class="card">
      <h2 class="section-title">📍 مقصدت را انتخاب کن</h2>

      <div class="fields">
        <div class="field">
          <label for="station">ایستگاه</label>
          <select id="station">
            <option value="aftab">ایستگاه آفتاب (آزمایشی)</option>
            <option value="daneshgah">ایستگاه دانشگاه (آزمایشی)</option>
            <option value="bagh">ایستگاه باغ (آزمایشی)</option>
          </select>
        </div>

        <div class="field">
          <label for="direction">جهت حرکت</label>
          <select id="direction"></select>
        </div>
      </div>
    </section>

    <section class="card result" aria-labelledby="resultTitle">
      <div class="result-label" id="resultTitle">زمان باقی‌مانده تا حرکت بعدی</div>
      <div id="countdown" aria-live="off">--:--:--</div>
      <div id="status" role="status" aria-live="polite">
        در حال محاسبه...
      </div>
      <div class="departure-time">
        حرکت بعدی: <strong id="nextDeparture">--:--</strong>
      </div>
      <div id="warning" class="warning" role="status">
        ⏰ کمتر از پنج دقیقه تا حرکت باقی مانده است!
      </div>
    </section>

    <section class="card">
      <h2 class="section-title">🕒 حرکت‌های باقی‌مانده امروز</h2>
      <ul id="scheduleList" class="schedule-list"></ul>
      <div id="scheduleEmpty" class="empty" hidden>
        حرکت دیگری برای امروز در جدول ثبت نشده است.
      </div>
    </section>

    <div class="notice">
      <strong>⚠️ توجه: نسخه آزمایشی</strong>
      <p>
        ایستگاه‌ها و زمان‌های این صفحه ساختگی و صرفاً برای آزمایش برنامه
        هستند. برای سفر واقعی به این زمان‌ها اعتماد نکنید.
        <br>
        برای بررسی اطلاعات رسمی، به
        <a href="https://metro.gov.az/en/page/muddealar/depo-qatarlarinin-hereket-cedveli"
           target="_blank" rel="noopener noreferrer">
          صفحه زمان‌بندی رسمی متروی باکو
        </a>
        مراجعه کنید.
      </p>
    </div>

    <footer class="footer">
      مترویار · یک پروژه آموزشی با HTML، CSS و JavaScript
    </footer>
  </main>

  <script>
    /*
      تمام زمان‌های زیر داده‌های آزمایشی هستند.
      این ساعت‌ها برنامه واقعی هیچ مترویی نیستند.
      زمان‌ها با قالب 24 ساعته نوشته می‌شوند.
    */

    const sampleData = {
      aftab: {
        name: "ایستگاه آفتاب",
        directions: {
          north: {
            label: "به سمت شمال",
            times: ["06:00", "07:30", "09:00", "12:00",
                    "15:00", "18:00", "20:30", "23:30"]
          },
          south: {
            label: "به سمت جنوب",
            times: ["06:15", "08:00", "10:30", "13:00",
                    "16:30", "19:00", "21:00", "23:45"]
          }
        }
      },

      daneshgah: {
        name: "ایستگاه دانشگاه",
        directions: {
          east: {
            label: "به سمت شرق",
            times: ["06:10", "07:00", "08:30", "11:00",
                    "14:00", "17:00", "19:30", "22:30"]
          },
          west: {
            label: "به سمت غرب",
            times: ["06:20", "07:45", "09:30", "12:30",
                    "15:30", "18:30", "21:30", "23:20"]
          }
        }
      },

      bagh: {
        name: "ایستگاه باغ",
        directions: {
          center: {
            label: "به سمت مرکز",
            times: ["06:30", "08:15", "10:00", "12:45",
                    "15:45", "18:15", "20:00", "22:45"]
          }
        }
      }
    };

    const stationSelect = document.getElementById("station");
    const directionSelect = document.getElementById("direction");
    const currentTimeEl = document.getElementById("currentTime");
    const currentDateEl = document.getElementById("currentDate");
    const countdownEl = document.getElementById("countdown");
    const statusEl = document.getElementById("status");
    const nextDepartureEl = document.getElementById("nextDeparture");
    const warningEl = document.getElementById("warning");
    const scheduleListEl = document.getElementById("scheduleList");
    const scheduleEmptyEl = document.getElementById("scheduleEmpty");

    const faDigits = value =>
      String(value).replace(/\d/g, digit => "۰۱۲۳۴۵۶۷۸۹"[digit]);

    function formatTime(date) {
      return new Intl.DateTimeFormat("fa-IR", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: false
      }).format(date);
    }

    function formatDuration(totalSeconds) {
      const hours = Math.floor(totalSeconds / 3600);
      const minutes = Math.floor((totalSeconds % 3600) / 60);
      const seconds = totalSeconds % 60;

      return [hours, minutes, seconds]
        .map(number => String(number).padStart(2, "0"))
        .join(":");
    }

    function updateClock(now) {
      currentTimeEl.textContent = new Intl.DateTimeFormat("fa-IR", {
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: false
      }).format(now);

      currentDateEl.textContent = new Intl.DateTimeFormat("fa-IR", {
        weekday: "long",
        year: "numeric",
        month: "long",
        day: "numeric"
      }).format(now);
    }

    function updateDirections() {
      const station = sampleData[stationSelect.value];
      const previousValue = directionSelect.value;

      directionSelect.replaceChildren();

      for (const [key, direction] of Object.entries(station.directions)) {
        const option = document.createElement("option");
        option.value = key;
        option.textContent = direction.label;
        directionSelect.appendChild(option);
      }

      if (station.directions[previousValue]) {
        directionSelect.value = previousValue;
      }
    }

    function getTodayDepartures(now) {
      const station = sampleData[stationSelect.value];
      const direction = station.directions[directionSelect.value];

      if (!direction) return [];

      return direction.times.map(time => {
        const [hours, minutes] = time.split(":").map(Number);
        const departure = new Date(now);
        departure.setHours(hours, minutes, 0, 0);

        return { time, departure };
      });
    }

    function renderSchedule(departures, now) {
      scheduleListEl.replaceChildren();

      const upcoming = departures.filter(item => item.departure > now);

      scheduleEmptyEl.hidden = upcoming.length !== 0;

      for (const item of upcoming) {
        const seconds = Math.ceil((item.departure - now) / 1000);
        const li = document.createElement("li");

        const time = document.createElement("span");
        time.className = "time";
        time.textContent = faDigits(item.time);

        const remaining = document.createElement("span");
        remaining.className = "remaining";
        remaining.textContent =
          "تا " + faDigits(Math.ceil(seconds / 60)) + " دقیقه دیگر";

        li.append(time, remaining);
        scheduleListEl.appendChild(li);
      }
    }

    function render(now = new Date()) {
      updateClock(now);

      const departures = getTodayDepartures(now);
      const next = departures.find(item => item.departure > now);

      renderSchedule(departures, now);

      warningEl.classList.remove("show");

      if (!next) {
        countdownEl.textContent = "--:--:--";
        nextDepartureEl.textContent = "ندارد";
        statusEl.textContent =
          "حرکت دیگری برای امروز در جدول آزمایشی ثبت نشده است.";
        return;
      }

      const seconds = Math.ceil((next.departure - now) / 1000);

      countdownEl.textContent = formatDuration(seconds);
      nextDepartureEl.textContent = faDigits(next.time);
      statusEl.textContent =
        "از ایستگاه " + sampleData[stationSelect.value].name +
        " · " + sampleData[stationSelect.value]
          .directions[directionSelect.value].label;

      if (seconds <= 300) {
        warningEl.classList.add("show");
      }
    }

    stationSelect.addEventListener("change", () => {
      updateDirections();
      render();
    });

    directionSelect.addEventListener("change", () => render());

    updateDirections();
    render();

    // ساعت و شمارش معکوس هر ثانیه به‌روزرسانی می‌شوند.
    setInterval(() => render(), 1000);
  </script>
</body>
</html>
