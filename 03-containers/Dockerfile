# Minimal nginx container
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy custom html
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
