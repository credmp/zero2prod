use std::net::TcpListener;

use actix_web::{dev::Server, web, App, HttpServer};

use crate::routes;

pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(|| {
        let app = {
            App::new()
                .route("/health_check", web::get().to(routes::health_check))
                .route("/subscriptions", web::post().to(routes::subscribe))
        };
        app
    })
    .listen(listener)?
    .run();

    Ok(server)
}
