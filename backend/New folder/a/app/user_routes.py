from fastapi import APIRouter, HTTPException, Depends
from sqlmodel import select, Session
from app.models import Hero, HeroCreate, HeroPublic, HeroUpdate
from app.database import get_session

router = APIRouter()

@router.post("/", response_model=HeroPublic)
def create_hero(hero: HeroCreate, session: Session = Depends(get_session)):
    db_hero = Hero.from_orm(hero)
    session.add(db_hero)
    session.commit()
    session.refresh(db_hero)
    return db_hero

@router.get("/", response_model=list[HeroPublic])
def get_heroes(session: Session = Depends(get_session)):
    return session.exec(select(Hero)).all()

@router.get("/{hero_id}", response_model=HeroPublic)
def get_hero(hero_id: int, session: Session = Depends(get_session)):
    hero = session.get(Hero, hero_id)
    if not hero:
        raise HTTPException(status_code=404, detail="Hero not found")
    return hero

@router.patch("/{hero_id}", response_model=HeroPublic)
def update_hero(hero_id: int, hero: HeroUpdate, session: Session = Depends(get_session)):
    hero_db = session.get(Hero, hero_id)
    if not hero_db:
        raise HTTPException(status_code=404, detail="Hero not found")
    hero_data = hero.dict(exclude_unset=True)
    for key, value in hero_data.items():
        setattr(hero_db, key, value)
    session.add(hero_db)
    session.commit()
    session.refresh(hero_db)
    return hero_db

@router.delete("/{hero_id}")
def delete_hero(hero_id: int, session: Session = Depends(get_session)):
    hero = session.get(Hero, hero_id)
    if not hero:
        raise HTTPException(status_code=404, detail="Hero not found")
    session.delete(hero)
    session.commit()
    return {"ok": True}
