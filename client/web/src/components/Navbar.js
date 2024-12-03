import { useState } from "react"
import SidebarItem from "./SidebarItem"

export default function NavBar(){
    const [ showsitesidebar, setShowsitesidebar ] = useState(false)
    return ( 
        <>
            <div className="navbar">
                <a href="#!">title</a>
                <div className="nav-links">
                    <a href="#">link1</a>
                    <a href="#">link2</a>
                    <a href="#">link3</a>
                </div>
                <div onClick={() =>{setShowsitesidebar(!showsitesidebar)}} className={showsitesidebar ? "sidebar-btn active" : "sidebar-btn"}>
                    <div className="bar"></div>
                    <div className="bar"></div>
                    <div className="bar"></div>
                </div>
            </div>
            <SidebarItem />
        </>
    )
}