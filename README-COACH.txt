Fourstarr Chess Coach v0.9 — Gemini conversational coach

IMPORTANT: This package must be deployed using Git-based Netlify builds or Netlify CLI (netlify deploy --prod --build); static drag-and-drop may not deploy functions.

1. Create a Gemini API key using Google AI Studio (https://aistudio.google.com/apikey). Free API quotas may be available but depend on account, model, and region; check billing and limits. Never put keys in index.html or send them in chat.
2. Netlify > your site > Site configuration > Environment variables. Add:
   GEMINI_API_KEY = your Google Gemini API key
   COACH_ACCESS_CODE = a long random private phrase you choose
   GEMINI_MODEL = gemini-2.5-flash (optional; default; availability may change)
3. For both variables, include Functions scope and appropriate production context, then redeploy.
4. In the app: Coach connection settings > enter the access code > Use code for this tab. Load a game, analyze a position with Stockfish, then Ask coach.
5. The board and engine run locally on the iPad. Gemini requests go through the Netlify Function and require internet. Chat stays in browser storage, not Supabase.

Netlify function: netlify/functions/coach.js
Endpoint: /.netlify/functions/coach

If you see a 404 on the function, your deployment included only static files. Use Netlify's Git-based build or CLI. If you see Gemini API error 404, adjust GEMINI_MODEL to a supported model. If you see 429, check quota. If you see 401, check COACH_ACCESS_CODE.

Security: the access code is a lightweight guard, not a full authentication/rate-limit solution. A publicly accessible site may incur API costs if the code leaks. For personal usage, keep it private and set quota/budget limits with your provider.
