# Watch backend logs in real-time
Write-Host "Watching backend API logs... Press Ctrl+C to stop" -ForegroundColor Green
Get-Content "backend/logs/spring.log" -Wait -Tail 20
