from fastapi import FastAPI, Request, Header, HTTPException
import httpx

app = FastAPI()

@app.get("/")
async def forward_request(
    request: Request,
    username: str = Header(..., alias="username-header"),
    password: str = Header(..., alias="pass-header"),
    company_id: str = Header(..., alias="companyID")
):
    # Beispiel-Ziel-URL basierend auf dem Kubernetes-Service im Namespace
    service_url = f"http://radius-service.{company_id}.svc.cluster.local"

    try:
        # Original-Body lesen
        body = await request.body()

        # Weiterleiten der Anfrage
        async with httpx.AsyncClient() as client:
            response = await client.post(
                service_url,
                content=body,
                headers={
                    "username-header": username,
                    "pass-header": password,
                    "companyID": company_id,
                    "content-type": request.headers.get("content-type", "application/json")
                },
                timeout=10.0
            )
        return {
            "status": response.status_code,
            "data": response.json()
        }

    except httpx.RequestError as e:
        raise HTTPException(status_code=502, detail=f"Service not reachable: {e}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))